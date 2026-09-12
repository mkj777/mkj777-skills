#!/usr/bin/env python3
"""Sendet genau eine Akquise-Mail über SMTP.

Konfiguration:  ~/.config/vbelt/config.json (überschreibbar mit VBELT_CONFIG)
                Abschnitte "identity" (name, email, intro_paragraph) und
                "mail" (host, port, user, bcc, password_env, password_file, keychain_service)
Passwort:       in dieser Reihenfolge: Umgebungsvariable aus mail.password_env
                (Standard VBELT_SMTP_PASSWORD), Datei aus mail.password_file
                (Standard ~/.config/vbelt/smtp-password), macOS-Keychain
                (Dienst mail.keychain_service, Standard "vbelt-smtp").

Aufruf:
    send-mail.py --to <adresse> --subject <betreff> --body-file <datei>
    send-mail.py --check         nur SMTP-Login prüfen
    send-mail.py ... --dry-run   Mail ausgeben, nicht senden
"""

import argparse
import json
import os
import shutil
import smtplib
import ssl
import stat
import subprocess
import sys
from email.message import EmailMessage
from email.utils import formataddr, formatdate, make_msgid

CONFIG_PATH = os.path.expanduser(os.environ.get("VBELT_CONFIG", "~/.config/vbelt/config.json"))
DEFAULT_PASSWORD_ENV = "VBELT_SMTP_PASSWORD"
DEFAULT_PASSWORD_FILE = "~/.config/vbelt/smtp-password"
DEFAULT_KEYCHAIN_SERVICE = "vbelt-smtp"

SETUP_HINT = """Mailversand ist nicht eingerichtet. Einmalig:

1. Konfiguration anlegen (Vorlage: config.example.json im Skill-Repo):

   {config_path}

   {{
     "identity": {{ "name": "Vorname Nachname", "email": "post@deine-domain.de",
                    "intro_paragraph": "Ich bin ... und suche ..." }},
     "mail": {{ "host": "mail.provider.de", "port": 465, "bcc": ["post@deine-domain.de"] }}
   }}

2. Postfach-Passwort hinterlegen, eine der drei Möglichkeiten:
   - Umgebungsvariable {password_env}
   - Datei {password_file} (nur für dich lesbar, eine Zeile)
   - macOS-Keychain: security add-generic-password -a "<adresse>" -s "{keychain_service}" -w

3. Prüfen: python3 send-mail.py --check
"""


def fail(message, code=1):
    print("FEHLER: " + message, file=sys.stderr)
    sys.exit(code)


def setup_hint(config=None):
    mail = (config or {}).get("mail", {}) if isinstance(config, dict) else {}
    return SETUP_HINT.format(
        config_path=CONFIG_PATH,
        password_env=mail.get("password_env") or DEFAULT_PASSWORD_ENV,
        password_file=mail.get("password_file") or DEFAULT_PASSWORD_FILE,
        keychain_service=mail.get("keychain_service") or DEFAULT_KEYCHAIN_SERVICE,
    )


def load_config():
    if not os.path.exists(CONFIG_PATH):
        fail("Konfiguration fehlt: {}\n\n{}".format(CONFIG_PATH, setup_hint()))
    try:
        with open(CONFIG_PATH, "r", encoding="utf-8") as handle:
            config = json.load(handle)
    except json.JSONDecodeError as error:
        fail("Konfiguration ist kein gültiges JSON ({}): {}".format(CONFIG_PATH, error))

    identity = config.get("identity") or {}
    mail = config.get("mail") or {}
    missing = []
    if not identity.get("email"):
        missing.append("identity.email")
    if not mail.get("host"):
        missing.append("mail.host")
    if not mail.get("port"):
        missing.append("mail.port")
    if missing:
        fail("Konfigurationswerte fehlen: {}\n\n{}".format(", ".join(missing), setup_hint(config)))

    return {
        "from": identity["email"],
        "name": identity.get("name") or "",
        "user": mail.get("user") or identity["email"],
        "host": mail["host"],
        "port": int(mail["port"]),
        "bcc": mail.get("bcc") or [],
        "password_env": mail.get("password_env") or DEFAULT_PASSWORD_ENV,
        "password_file": os.path.expanduser(mail.get("password_file") or DEFAULT_PASSWORD_FILE),
        "keychain_service": mail.get("keychain_service") or DEFAULT_KEYCHAIN_SERVICE,
    }


def password_from_file(path):
    if not os.path.exists(path):
        return None
    if os.name != "nt":
        mode = stat.S_IMODE(os.stat(path).st_mode)
        if mode & 0o077:
            fail("Passwortdatei {} ist für andere lesbar. Bitte: chmod 600 {}".format(path, path))
    with open(path, "r", encoding="utf-8") as handle:
        value = handle.read().strip("\r\n")
    return value or None


def password_from_keychain(account, service):
    if shutil.which("security") is None:
        return None
    result = subprocess.run(
        ["security", "find-generic-password", "-a", account, "-s", service, "-w"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        return None
    return result.stdout.strip("\n") or None


def load_password(config):
    password = os.environ.get(config["password_env"])
    if password:
        return password
    password = password_from_file(config["password_file"])
    if password:
        return password
    password = password_from_keychain(config["user"], config["keychain_service"])
    if password:
        return password
    fail(
        "Kein Postfach-Passwort gefunden (Umgebungsvariable {}, Datei {}, Keychain-Dienst {}).\n\n{}".format(
            config["password_env"], config["password_file"], config["keychain_service"], setup_hint()
        )
    )


def connect(config, password):
    context = ssl.create_default_context()
    if config["port"] == 465:
        server = smtplib.SMTP_SSL(config["host"], config["port"], context=context, timeout=30)
    else:
        server = smtplib.SMTP(config["host"], config["port"], timeout=30)
        server.starttls(context=context)
    server.login(config["user"], password)
    return server


def resolve_bcc(config, args):
    """Blindkopien fürs Archiv: SMTP legt nichts im Gesendet-Ordner ab."""
    if args.no_bcc:
        return ""
    if args.bcc:
        raw = args.bcc.replace(";", ",").split(",")
    else:
        raw = config["bcc"] if isinstance(config["bcc"], list) else str(config["bcc"]).replace(";", ",").split(",")
    addresses = [part.strip() for part in raw if part and part.strip()]
    return ", ".join(addresses)


def build_message(config, args, body, bcc):
    message = EmailMessage()
    message["From"] = formataddr((config["name"], config["from"])) if config["name"] else config["from"]
    message["To"] = args.to
    if bcc:
        # smtplib.send_message nimmt Bcc als Empfänger auf und entfernt den Header vor dem Versand.
        message["Bcc"] = bcc
    message["Subject"] = args.subject
    message["Date"] = formatdate(localtime=True)
    message["Message-ID"] = make_msgid(domain=config["from"].split("@")[-1])
    if args.reply_to:
        message["Reply-To"] = args.reply_to
    if args.in_reply_to:
        message["In-Reply-To"] = args.in_reply_to
        message["References"] = args.in_reply_to
    message.set_content(body, cte="quoted-printable")
    return message


def main():
    parser = argparse.ArgumentParser(description="Sendet genau eine Akquise-Mail.")
    parser.add_argument("--to", help="Empfängeradresse (genau eine)")
    parser.add_argument("--subject", help="Betreff")
    parser.add_argument("--body-file", help="Datei mit dem Mailtext (UTF-8, reiner Text)")
    parser.add_argument("--reply-to", help="Abweichende Antwortadresse")
    parser.add_argument("--in-reply-to", help="Message-ID der Erstmail, für das Nachfassen im Verlauf")
    parser.add_argument("--bcc", help="Blindkopie(n), kommagetrennt, überschreibt mail.bcc aus der Konfiguration")
    parser.add_argument("--no-bcc", action="store_true", help="Keine Blindkopie senden")
    parser.add_argument("--check", action="store_true", help="Nur SMTP-Login prüfen, nichts senden")
    parser.add_argument("--dry-run", action="store_true", help="Mail nur ausgeben, nicht senden")
    args = parser.parse_args()

    config = load_config()

    if args.check:
        password = load_password(config)
        try:
            server = connect(config, password)
        except smtplib.SMTPAuthenticationError:
            fail("Login abgelehnt. Benutzername oder Postfach-Passwort prüfen.")
        except Exception as error:  # noqa: BLE001 - Netzwerk-/TLS-Fehler sollen lesbar bleiben
            fail("Verbindung fehlgeschlagen: {}".format(error))
        server.quit()
        print("SMTP-Login erfolgreich: {} über {}:{}".format(config["user"], config["host"], config["port"]))
        return

    missing = [name for name in ("to", "subject", "body_file") if not getattr(args, name)]
    if missing:
        fail("Fehlende Argumente: " + ", ".join("--" + name.replace("_", "-") for name in missing))

    if "," in args.to or ";" in args.to:
        fail("Nur ein Empfänger pro Aufruf. Kein Stapelversand.")

    if not os.path.exists(args.body_file):
        fail("Textdatei nicht gefunden: {}".format(args.body_file))
    with open(args.body_file, "r", encoding="utf-8") as handle:
        body = handle.read()
    if not body.strip():
        fail("Der Mailtext ist leer.")
    for placeholder in ("{INTRO-ABSATZ}", "{ABSENDER-NAME}", "{ABSENDER-ADRESSE}", "{DEMO-URL}", "{VERBESSERUNGEN}"):
        if placeholder in body:
            fail("Platzhalter {} steht noch im Mailtext.".format(placeholder))

    bcc = resolve_bcc(config, args)
    message = build_message(config, args, body, bcc)

    if args.dry_run:
        print(message)
        print("--- dry-run, nichts gesendet ---", file=sys.stderr)
        return

    password = load_password(config)
    try:
        server = connect(config, password)
    except smtplib.SMTPAuthenticationError:
        fail("Login abgelehnt. Benutzername oder Postfach-Passwort prüfen.")
    except Exception as error:  # noqa: BLE001
        fail("Verbindung fehlgeschlagen: {}".format(error))

    try:
        server.send_message(message)
    except smtplib.SMTPException as error:
        fail("Versand fehlgeschlagen: {}".format(error))
    finally:
        server.quit()

    print("Gesendet an {}".format(args.to))
    if bcc:
        print("Blindkopie an {}".format(bcc))
    print("Message-ID: {}".format(message["Message-ID"]))


if __name__ == "__main__":
    main()
