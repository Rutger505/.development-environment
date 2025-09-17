#!/bin/bash

echo "Enabeling os-prober"
sudo sed -i -E 's/^#?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub

echo "Shorting timeout to 2 second"
sudo sed -i -E 's/^#?\s*GRUB_TIMEOUT=.*/GRUB_TIMEOUT=2/' /etc/default/grub

sudo grub-install --target=x86_64-efi \
	--bootloader-id=GRUB \
	--removable \
	--efi-directory=/boot/efi \
	--boot-directory=/boot \
	--recheck
sudo grub-mkconfig -o /boot/grub/grub.cfg
