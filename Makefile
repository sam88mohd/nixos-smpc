.PHONY: run

run:
	sudo nixos-rebuild switch --flake ./#smpc

.PHONY: clean

clean:
	sudo nix-collect-garbage -d

.PHONY: update

update:
	sudo nix flake update
