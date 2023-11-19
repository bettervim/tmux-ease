run:
	dune build && dune exec tmux_ease e2e/tmux.toml e2e/tmux.conf

eval-opam:
	eval $(opam config env)

create-switch:
	opam switch create . 5.1.0 --deps-only --with-test -y

install: 
	opam install . --deps-only --with-test --with-doc

build:
	dune build
