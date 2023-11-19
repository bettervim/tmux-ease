(lang dune 3.11)

(name tmux_ease)

(generate_opam_files true)

(source
 (github bettervim/tmux-json))

(authors "Marcos Oliveira")

(maintainers "Marcos Oliveira")

(implicit_transitive_deps false)

(license MIT)

(package
 (name tmux_ease)
 (synopsis "Manage your tmux.conf using JSON or TOML files")
 (description "Manage your tmux.conf using JSON or TOML files")
(source
 (github bettervim/tmux_conf))

 (depends 
   (ocaml  (= 5.1.0))
   dune 
   stdio
   result
   base
   core
   re
   toml
   (yojson  (>= 1.6.0))
   (ppx_deriving_yojson (= 3.7.0) )

  ;;Dev-only
  (ocamlformat
   (and (= 0.26.1)
      :with-test))
    (ocaml-lsp-server :with-test)
 )
 (tags
  (topics tmux "tmux.conf" "tmux-json")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
