#!/bin/bash

prompt_installation "Zen browser" || return 0

bash <(curl https://updates.zen-browser.app/appimage.sh)
