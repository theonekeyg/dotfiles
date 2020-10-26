.PHONY: backup install rm-backup

all:

backup:
	test ! -f $(HOME)/.agignore || mv $(HOME)/.agignore $(HOME)/.agignore.bak
	test ! -f $(HOME)/.bashrc || mv $(HOME)/.bashrc $(HOME)/.bashrc.bak
	test ! -f $(HOME)/.dircolors || mv $(HOME)/.dircolors $(HOME)/.dircolors.bak
	test ! -f $(HOME)/.gitconfig || mv $(HOME)/.gitconfig $(HOME)/.gitconfig.bak
	test ! -f $(HOME)/.gitignore || mv $(HOME)/.gitignore $(HOME)/.gitignore.bak
	test ! -f $(HOME)/.tmux.conf || mv $(HOME)/.tmux.conf $(HOME)/.tmux.conf.bak
	test ! -f $(HOME)/.xinitrc || mv $(HOME)/.xinitrc $(HOME)/.xinitrc.bak
	test ! -f $(HOME)/.xprofile || mv $(HOME)/.xprofile $(HOME)/.xprofile.bak
	test ! -f $(HOME)/.Xresources || mv $(HOME)/.Xresources $(HOME)/.Xresources.bak

rm-backup:
	rm -rf $(HOME)/.agignore.bak
	rm -rf $(HOME)/.bashrc.bak
	rm -rf $(HOME)/.dircolors.bak
	rm -rf $(HOME)/.gitconfig.bak
	rm -rf $(HOME)/.gitignore.bak
	rm -rf $(HOME)/.tmux.conf.bak
	rm -rf $(HOME)/.xinitrc.bak
	rm -rf $(HOME)/.xprofile.bak
	rm -rf $(HOME)/.Xresources.bak
	cd `pwd`/.config && make rm-backup
	
install: backup
	ln -sf `pwd`/.agignore $(HOME)/.agignore
	ln -sf `pwd`/.bashrc $(HOME)/.bashrc
	ln -sf `pwd`/.dircolors $(HOME)/.dircolors
	ln -sf `pwd`/.gitconfig $(HOME)/.gitconfig
	ln -sf `pwd`/.gitignore $(HOME)/.gitignore
	ln -sf `pwd`/.tmux.conf $(HOME)/.tmux.conf
	ln -sf `pwd`/.xinitrc $(HOME)/.xinitrc
	ln -sf `pwd`/.xprofile $(HOME)/.xprofile
	ln -sf `pwd`/.Xresources $(HOME)/.Xresources
	cd `pwd`/.config && make install
