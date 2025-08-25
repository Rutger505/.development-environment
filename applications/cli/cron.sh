#!/bin/bash

yay -S cronie
sudo systemctl enable --now cronie.service