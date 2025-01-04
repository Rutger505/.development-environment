#!/bin/bash

prompt_installation "PHPStorm" || return 0

sudo snap install phpstorm --classic
