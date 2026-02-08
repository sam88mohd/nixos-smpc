.PHONY: run

run:
	sudo nixos-rebuild switch --flake ./#smpc

.PHONY: clean

clean:
<<<<<<< HEAD
	sudo nixos-collect-garbage -d
