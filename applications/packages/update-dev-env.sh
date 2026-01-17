#!/bin/bash

echo "Enabling update-dev-env timer"
systemctl --user enable --now update-dev-env.timer
