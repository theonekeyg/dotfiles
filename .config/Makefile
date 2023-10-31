CC = /usr/bin/gcc
C_FLAGS = -std=c99 -Wall -fPIC
.PHONY: backup install rm-backup

backup:
	test ! -d $(HOME)/.config/i3 || mv -T $(HOME)/.config/i3 $(HOME)/.config/i3.bak
	test ! -d $(HOME)/.config/i3blocks || mv -T $(HOME)/.config/i3blocks $(HOME)/.config/i3blocks.bak
	test ! -d $(HOME)/.config/nvim || mv -T $(HOME)/.config/nvim $(HOME)/.config/nvim.bak
	test ! -d $(HOME)/.config/alacritty || mv -T $(HOME)/.config/alacritty $(HOME)/.config/alacritty.bak

rm-backup:
	rm -rf $(HOME)/.config/i3.bak
	rm -rf $(HOME)/.config/i3blocks.bak
	rm -rf $(HOME)/.config/nvim.bak
	rm -rf $(HOME)/.config/alacritty.bak

install: backup
	ln -sf `pwd`/i3 $(HOME)/.config/i3
	ln -sf `pwd`/i3blocks $(HOME)/.config/i3blocks
	$(CC) $(C_FLAGS) -o $(HOME)/.config/i3blocks/cpu-load i3blocks/cpu-load.c
	ln -sf `pwd`/nvim $(HOME)/.config/nvim
	ln -sf `pwd`/alacritty $(HOME)/.config/alacritty
