#!/bin/bash

# TODO move to pachage lists
sudo pacman -S --needed gcc git make flex bison gperf python cmake ninja ccache dfu-util libusb python-pip

dir=${XDG_DATA_HOME:-$HOME/.local/share}/esp
if [ -d "$dir/esp-idf" ]; then
    echo "ESP-IDF already installed in $dir/esp-idf"
    exit 0
fi
mkdir -p "$dir"
cd $dir || exit 1
git clone -b master --recursive https://github.com/espressif/esp-idf.git