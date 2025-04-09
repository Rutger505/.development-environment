#!/bin/bash

# Check if an argument was provided
if [ -z "$1" ]; then
    echo "Please provide a package manager (npm, pnpm or bun) as an argument"
    exit 1
fi

# Validate package manager argument
case $1 in
    npm|pnpm|bun)
        PKG_MGR=$1
        ;;
    *)
        echo "Invalid package manager. Please use npm, pnpm or bun"
        exit 1
        ;;
esac

# Install dependencies
echo "Installing Prettier and plugins..."
$PKG_MGR install -D prettier prettier-plugin-organize-imports

# Create .prettierrc
echo "Creating .prettierrc..."
echo '{
  "plugins": [
    "prettier-plugin-organize-imports"
  ]
}' > .prettierrc

# Add scripts to package.json
echo "Adding scripts to package.json..."
jq '.scripts += {
  "format": "prettier --write --cache .",
  "format:check": "prettier --check --cache ."
}' package.json > temp.json && mv temp.json package.json

echo "Setup complete! You can now run:"
echo "  $PKG_MGR run format        # To format files"
echo "  $PKG_MGR run format:check  # To check formatting"

