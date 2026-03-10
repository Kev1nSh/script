#!/bin/bash

CSV_FILE=$1
BASE_DN="dc=nodomain"
USERS_OU="ou=users,$BASE_DN"
ADMIN_DN="cn=admin,$BASE_DN"

if [[ -z "$CSV_FILE" ]]; then
    echo "Ingen CSV-fil angiven."
    exit 1
fi

if [[ ! -f "$CSV_FILE" ]]; then
    echo "CSV-filen finns inte."
    exit 1
fi

read -s -p "Ange LDAP admin-lösenord: " LDAP_PASS
echo

tail -n +2 "$CSV_FILE" | while IFS=, read -r uid firstname lastname email
do
    if ldapsearch -x -LLL -D "$ADMIN_DN" -w "$LDAP_PASS" -b "$USERS_OU" "(uid=$uid)" | grep -q "^dn:"; then
        echo "Användaren $uid finns redan. Hoppar över."
        continue
    fi

    TMP_LDIF=$(mktemp)

    cat > "$TMP_LDIF" <<EOF
dn: uid=$uid,$USERS_OU
objectClass: inetOrgPerson
cn: $firstname $lastname
sn: $lastname
uid: $uid
mail: $email
EOF

    echo "Lägger till användare: $uid"
    ldapadd -x -D "$ADMIN_DN" -w "$LDAP_PASS" -f "$TMP_LDIF"

    rm -f "$TMP_LDIF"
done

echo "Import klar."