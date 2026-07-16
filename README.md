![Bash](https://img.shields.io/badge/language-bash-blue)
![Automation](https://img.shields.io/badge/topic-automation-green)
![Monitoring](https://img.shields.io/badge/topic-monitoring-orange)

# Nexus-Courier

## [DE]
`nexus-courier` ist ein robustes Bash-Skript, das entwickelt wurde, um Statusberichte oder Log-Dateien von Linux-Servern automatisiert per E-Mail zu versenden. Es ist darauf ausgelegt, in komplexen Netzwerkinfrastrukturen als zuverlässiger Bote (Courier) zu fungieren.

### Funktionen
- **Flexibel:** Empfänger kann direkt beim Aufruf als Parameter übergeben werden.
- **Robust:** Prüft Abhängigkeiten (`msmtp`, `cat`) und die Existenz der Konfigurationsdatei vor dem Versand.
- **Dokumentiert:** Eingebaute Hilfe-Funktion (`-h`).
- **Headless-Ready:** Ideal für Debian/ Ubuntu Umgebungen.

### Installation & Setup
1. Stelle sicher, dass `msmtp` installiert ist.
2. Konfiguriere die SMTP-Verbindung über `~/.msmtprc` (siehe unten).
3. Für eine sichere Passwortverwaltung nutze das Hilfsskript `pw-datei-erstellen.sh`, um deine verschlüsselte Konfiguration vorzubereiten.
4. Setze Ausführungsrechte: `chmod +x nexus-courier.sh`

### Konfiguration (.msmtprc & Sicherheit)
Erstelle die Datei `~/.msmtprc` und passe sie an deinen SMTP-Anbieter an:

```bash
defaults
auth            on
tls             on
tls_starttls    on
logfile         ~/.msmtp.log

account         dein_account_name
host            smtp.dein-anbieter.de
port            587
from            deine-mail@beispiel.de
user            dein-username
passwordeval    gpg -d ~/.msmtp-password.gpg

```

*Wichtig:*
1. Schütze die Datei: `chmod 600 ~/.msmtprc`
2. Nutze `./pw-datei-erstellen.sh`, um dein Passwort in `~/.msmtp-password.gpg` zu speichern, damit es nicht im Klartext in der Konfiguration liegt.

### Benutzung
`./nexus-courier.sh [EMPFÄNGER]`

---

## [ENG]
`nexus-courier` is a robust bash script designed to automatically send status reports or log files from Linux servers via email. It is built to serve as a reliable courier within complex network infrastructures.

### Features
- **Flexible:** Recipient can be passed as a parameter during execution.
- **Robust:** Validates dependencies (`msmtp`, `cat`) and configuration file existence before sending.
- **Documented:** Built-in help function (`-h`).
- **Headless-Ready:** Ideal for Debian / Ubuntu  environments.

### Installation & Setup
1. Ensure `msmtp` is installed.
2. Configure the SMTP connection via `~/.msmtprc` (see below).
3. For secure password management, use the helper script `pw-datei-erstellen.sh` to prepare your encrypted configuration.
4. Set execution permission: `chmod +x nexus-courier.sh`

### Configuration (.msmtprc & Security)
Create the `~/.msmtprc` file and adjust it to your SMTP provider:
```bash
defaults
auth            on
tls             on
tls_starttls    on
logfile         ~/.msmtp.log

account         your_account_name
host            smtp.your-provider.de
port            587
from            your-mail@example.com
user            your-username
passwordeval    gpg -d ~/.msmtp-password.gpg

```

*Important:*
1. Secure the file: `chmod 600 ~/.msmtprc`
2. Use `./pw-datei-erstellen.sh` to save your password in `~/.msmtp-password.gpg` to avoid storing plain text passwords in your configuration.

### Usage
`./nexus-courier.sh [RECIPIENT]`


---

### Powered by AI

#EOF
