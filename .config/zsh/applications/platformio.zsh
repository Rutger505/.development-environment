###### PlatformIO ######
if [ -d ~/.platformio/penv ]; then
  PATH="$PATH:$HOME/.platformio/penv/bin/platformio"
  PATH="$PATH:$HOME/.platformio/penv/bin/pio"
  PATH="$PATH:$HOME/.platformio/penv/bin/piodebuggdb"
fi
