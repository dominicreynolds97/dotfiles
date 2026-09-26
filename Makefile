COMMON = nvim tmux git zsh vim
MAC = hammerspoon
ARCH = i3 mangohud xinit
ARCH_ROOT = keyd

stow_dirs = $(filter-out $(addsuffix /,$(ARCH_ROOT)),$(wildcard */))

.PHONY : stow-mac stow-arch stow-arch-root restow-mac restow-arch restow-arch-root install-arch dump-arch delete delete-arch-root

stow-mac :
	stow --target $(HOME) --verbose $(COMMON) $(MAC)

stow-arch :
	stow --target $(HOME) --verbose $(COMMON) $(ARCH)

stow-arch-root :
	sudo stow --target / --no-folding --verbose $(ARCH_ROOT)
	sudo systemctl enable --now keyd

restow-mac:
	stow --target $(HOME) --verbose --restow $(COMMON) $(MAC)

restow-arch:
	stow --target $(HOME) --verbose --restow $(COMMON) $(ARCH)

restow-arch-root :
	sudo stow --target / --no-folding --verbose --restow $(ARCH_ROOT)
	sudo keyd reload

install-arch :
	sudo pacman -S --needed - < pkglist.txt
	yay -S --needed - < aurlist.txt

dump-arch :
	pacman -Qqen | grep -vxFf pkgignore.txt > pkglist.txt
	pacman -Qqem | grep -v -- '-debug$$' | grep -vxFf pkgignore.txt > aurlist.txt

delete :
	stow --target $(HOME) --verbose --delete $(stow_dirs)

delete-arch-root :
	sudo stow --target / --verbose --delete $(ARCH_ROOT)
