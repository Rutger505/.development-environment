#!/bin/bash

dir=${XDG_DATA_HOME:-$HOME/.local/share}/esp
if [ -d "$dir/esp-idf" ]; then
    echo "ESP-IDF already installed in $dir/esp-idf"
    exit 0
fi
mkdir -p "$dir"
cd $dir || exit 1
git clone -b master --recursive https://github.com/espressif/esp-idf.git

cd esp-idf || exit 1
./install.sh esp32
