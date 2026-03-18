# LDAP Script

Scripten skrivet i en kombination av Python och Bash.  
Scriptet används för att automatisera skapandet av flera användare i en Linux-miljö som använder LDAP.

Scriptet läser användarinformation från en CSV-fil och skapar användarkonton samt tilldelar rätt grupper automatiskt.

Syftet är att förenkla användarhantering i en LDAP-baserad miljö och demonstrera automatisering av administrativa uppgifter i Linux.

## Användning

sudo ./import_users.py users.csv
