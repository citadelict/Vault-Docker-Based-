#!/bin/sh

# Wait for Vault to be ready
until vault status > /dev/null 2>&1; do
  echo "Waiting for Vault to be ready..."
  sleep 2
done

# Check if Vault is initialized
if vault status | grep "Initialized" | grep "false"; then
  echo "Initializing Vault..."
  INIT_OUTPUT=$(vault operator init -format=json)
  ROOT_TOKEN=$(echo "$INIT_OUTPUT" | jq -r '.root_token')
  echo "Vault initialized. Root token: $ROOT_TOKEN"
  echo "Save the root token securely!"
else
  echo "Vault is already initialized."
fi
