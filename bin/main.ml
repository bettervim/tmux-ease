let main () =
  let config_filename = Arguments.get_filename () in
  let config_result = TmuxConfig.from_file config_filename in
  match config_result with
  | Ok config -> (
      Printer.(
        try Printer.print config
        with InvalidKey message -> print_endline message))
  | Error error ->
      print_endline ("⚠️  Error whilte trying to parse tmux.json: " ^ error)
;;

main ()
