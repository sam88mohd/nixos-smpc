.PHONY: run

run:
	sudo nixos-rebuild switch --flake ./#smpc

.PHONY: upgrade

upgrade:
	sudo nixos-rebuild switch --upgrade --flake ./#smpc

.PHONY: clean

clean:
	sudo nix-collect-garbage -d
