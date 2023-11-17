let main () =
  let config_filename = Arguments.get_filename () in
  let parsed_json =
    Yojson.Safe.from_file config_filename |> TmuxConfig.from_json
  in
  match parsed_json with
  | Ok config -> (
      Printer.(
        try Printer.print config
        with InvalidKey message -> print_endline message))
  | Error error ->
      print_endline ("⚠️  Error whilte trying to parse tmux.json: " ^ error)
;;

main ()
