.PHONY: run

run:
	sudo nixos-rebuild switch --flake ./#smpc

.PHONY: clean

run:
	sudo nixos-collect-garbage -d
