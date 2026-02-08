.PHONY: run

run:
	sudo nixos-rebuild switch --flake /home/sm/nixos/hosts/default/#smpc

.PHONY: clean

clean:
	sudo nix-collect-garbage -d
