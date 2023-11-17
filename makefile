run:
	dune build && ./_build/default/bin/main.exe e2e/tmux.json e2e/tmux.conf

eval-opam:
	eval $(opam config env)

create-switch:
	opam switch create . 5.1.0 --deps-only --with-test -y

install: 
	opam install . --deps-only --with-test --with-doc

build:
	dune build
