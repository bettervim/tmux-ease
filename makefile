run:
	dune build && dune exec tmux_conf

.PHONY: create-switch
create-switch:
	opam switch create . 5.1.0 --deps-only --with-test -y

.PHONY: install
install: 
	opam install . --deps-only --with-test --with-doc
