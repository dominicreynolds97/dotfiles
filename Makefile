COMMON = nvim tmux git zsh vim
MAC = hammerspoon
ARCH = i3 mangohud

stow_dirs = $(wildcard */)

.PHONY : stow-mac stow-arch restow-mac restow-arch delete

stow-mac :
	stow --target $(HOME) --verbose $(COMMON) $(MAC)

stow-arch :
	stow --target $(HOME) --verbose $(COMMON) $(ARCH)

restow-mac:
	stow --target $(HOME) --verbose --restow $(COMMON) $(MAC)

restow-arch:
	stow --target $(HOME) --verbose --restow $(COMMON) $(ARCH)

delete :
	stow -target $(HOME) --verbose --delete $(stow_dirs)
