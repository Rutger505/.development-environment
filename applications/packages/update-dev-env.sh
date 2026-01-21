#!/bin/bash

echo "Enabling dev-env-update-self timer"
systemctl --user enable --now dev-env-update-self.timer
