COMMON = nvim tmux git zsh vim
MAC = hammerspoon
ARCH = i3 dunst gtk kitty mangohud picom polybar rofi xinit
ARCH_ROOT = keyd greetd

stow_dirs = $(filter-out $(addsuffix /,$(ARCH_ROOT)),$(wildcard */))

.PHONY : stow-mac stow-arch stow-arch-root restow-mac restow-arch restow-arch-root install-arch dump-arch delete delete-arch-root install-root-copies

stow-mac :
	stow --target $(HOME) --verbose $(COMMON) $(MAC)

stow-arch :
	stow --target $(HOME) --verbose $(COMMON) $(ARCH)

# Copied, not stowed: the greeter user can't follow symlinks into $(HOME).
ROOT_COPIES = /etc/greetd/greeter.sh
STOW_ROOT = sudo stow --target / --no-folding --verbose --ignore='greeter\.sh'

install-root-copies :
	sudo install -Dm755 greetd/etc/greetd/greeter.sh /etc/greetd/greeter.sh

stow-arch-root : install-root-copies
	$(STOW_ROOT) $(ARCH_ROOT)
	sudo systemctl enable --now keyd
	sudo systemctl enable greetd

restow-mac:
	stow --target $(HOME) --verbose --restow $(COMMON) $(MAC)

restow-arch:
	stow --target $(HOME) --verbose --restow $(COMMON) $(ARCH)

restow-arch-root : install-root-copies
	$(STOW_ROOT) --restow $(ARCH_ROOT)
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
	$(STOW_ROOT) --delete $(ARCH_ROOT)
	sudo rm -f $(ROOT_COPIES)
