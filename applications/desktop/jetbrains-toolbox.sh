#!/bin/bash

# https://github.com/Rutger505/.development-environment/issues/10
export CI="skip-startup" && curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash
