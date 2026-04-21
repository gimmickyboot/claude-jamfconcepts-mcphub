#!/bin/sh

JAMF_PRO_CLIENT_SECRET="$(/usr/bin/security find-generic-password -a "${USER}" -s "jamf_token" -w)"
JAMF_PROTECT_PASSWORD="$(/usr/bin/security find-generic-password -a "${USER}" -s "protect_token" -w)"
JAMF_SECURITY_APP_SECRET="$(/usr/bin/security find-generic-password -a "${USER}" -s "seccloud_token" -w)"

if [ -z "${JAMF_PRO_CLIENT_SECRET}" ]; then
  echo "ERROR: Could not retrieve jamf_token from Keychain" >&2
fi

if [ -z "${JAMF_PROTECT_PASSWORD}" ]; then
  echo "ERROR: Could not retrieve protect_token from Keychain" >&2
fi

if [ -z "${JAMF_SECURITY_APP_SECRET}" ]; then
  echo "ERROR: Could not retrieve seccloud_token from Keychain" >&2
fi

export JAMF_PRO_URL="https://<your instance>.jamfcloud.com"
export JAMF_PRO_CLIENT_ID="<your client id>"
export JAMF_PRO_CLIENT_SECRET="$JAMF_PRO_CLIENT_SECRET"

export JAMF_PROTECT_URL="https://<your instance>.protect.jamfcloud.com"
export JAMF_PROTECT_CLIENT_ID="<your client id>"
export JAMF_PROTECT_PASSWORD="${JAMF_PROTECT_PASSWORD}"

export JAMF_SECURITY_URL="https://api.wandera.com"
export JAMF_SECURITY_APP_ID="<your client id>"
export JAMF_SECURITY_APP_SECRET="${JAMF_SECURITY_APP_SECRET}"

exec "<path to repo>/.venv/bin/python" -m jamf_mcp.server
