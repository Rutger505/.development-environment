#!/bin/bash

read -p "Are you **very** sure you want to delete ALL branches except 'main'? (y/N): " confirm

echo "Switching to main"
git checkout main


if [[ "$confirm" =~ ^[Yy]$ ]]; then
    git branch | grep -v "main" | xargs git branch -D
else
    echo "Aborted."
fi


