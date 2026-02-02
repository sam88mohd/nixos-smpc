.PHONY: run

run:
	sudo nixos-rebuild switch --flake ./#smpc

.PHONY: clean

clean:
	sudo nixos-collect-garbage -d
