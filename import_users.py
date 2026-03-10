import os
import subprocess

print("LDAP tool user import")
csv_file = input("Ange namnet på CSV-filen: ")

if not os.path.isfile(csv_file):
    print(f"Filen '{csv_file}' hittades inte.")
    exit(1)

print(f"Importerar användare från '{csv_file}'...")

subprocess.run(["bash", "./import_ldap_users.sh", csv_file])
print("Importen är klar.")