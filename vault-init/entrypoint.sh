#!/bin/sh

set -e

export VAULT_ADDR="${VAULT_ADDR:-http://vault:8200}"

echo "⏳ Waiting for Vault to become reachable at $VAULT_ADDR..."

# Wait for Vault's HTTP API to respond
until curl -s $VAULT_ADDR/v1/sys/health | grep -qE '"initialized":'; do
  echo "⏳ Still waiting for Vault to respond..."
  sleep 2
done

echo "✅ Vault is reachable."

# Check if Vault is already initialized
if vault status | grep -q 'Initialized.*true'; then
  echo "🔐 Vault is already initialized. Saving current status..."
  vault status -format=json > /vault-init/output/status.json
  exit 0
fi

echo "🚀 Vault is not initialized. Initializing..."

vault operator init -format=json > /vault-init/output/init.json

echo "✅ Vault initialized. Init credentials saved to /vault-init/output/init.json"
