#!/bin/bash

echo "Enabeling os-prober"
sudo sed -i -E 's/^#?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub

echo "Shorting timeout to 2 second"
sudo sed -i -E 's/^#?\s*GRUB_TIMEOUT=.*/GRUB_TIMEOUT=2/' /etc/default/grub


echo "Installing grub2-theme tela"
git clone https://github.com/vinceliuice/grub2-themes.git ~/.local/share/grub2-themes
cd ~/.local/share/grub2-themes
sudo ./install.sh -t tela -s 1080p
cd -


sudo grub-install --target=x86_64-efi \
	--bootloader-id=GRUB \
	--removable \
	--efi-directory=/boot/efi \
	--boot-directory=/boot \
	--recheck
sudo grub-mkconfig -o /boot/grub/grub.cfg
