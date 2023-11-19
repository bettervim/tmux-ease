let main () =
  let config_filename = Arguments.get_filename () in
  let config_result = TmuxConfig.from_file config_filename in
  match config_result with
  | Ok config -> (
      try Printer.print config
      with _ ->
        print_endline ("⚠️  Error whilte trying to parse: " ^ config_filename))
  | Error error ->
      print_endline ("⚠️  Error whilte trying to parse: " ^ error)
;;

main ()
