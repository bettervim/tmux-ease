open Core

exception InvalidKey of string

let filename = "/Users/admin/projects/tmux_conf/__examples/tmux.json"

let filename_output =
  "/Users/admin/projects/tmux_conf/__examples/generated-tmux.conf"

module TmuxConfig = struct
  type bind = {key: string list; command: string} [@@deriving yojson]

  type binds = bind list [@@deriving yojson]

  type t = {prefix: string list option; binds: binds option} [@@deriving yojson]
end

module Command = struct
  let from_string _ = ""
end

module Keys = struct
  type t = Ctrl | Shift | A | G

  let from_string raw_key =
    match raw_key with
    | "ctrl" ->
        Ctrl
    | "shift" ->
        Shift
    | "a" ->
        A
    | "g" ->
        G
    | key ->
        raise (InvalidKey ("⚠️  Invalid key provided: " ^ key))
end

module Printer = struct
  let append_line content new_line = content ^ "\n" ^ new_line

  let append_lines content lines =
    List.fold lines ~init:content ~f:(fun acc line -> append_line acc line)

  let generate_key keys =
    List.fold keys ~init:"" ~f:(fun acc current_key ->
        let parsed_key =
          match current_key |> Keys.from_string with
          | Ctrl ->
              "C"
          | Shift ->
              "S"
          | A ->
              "a"
          | G ->
              "g"
        in
        let prefix = match acc with "" -> acc | _ -> acc ^ "-" in
        prefix ^ parsed_key )

  let generate_prefix_bind (prefix_keys : string list) =
    let key = generate_key prefix_keys in
    "set -g prefix " ^ key

  let generate_binds (binds : TmuxConfig.binds) =
    List.map binds ~f:(fun bind ->
        let key = generate_key bind.key in
        "bind " ^ key ^ " " ^ bind.command )
    |> List.fold ~init:"" ~f:(fun lines bind -> append_line lines bind)

  let print (config : TmuxConfig.t) =
    let open TmuxConfig in
    let binds = config.binds |> Option.value_map ~f: generate_binds ~default: "" in
    let prefix = config.prefix  |> Option.value_map ~f: generate_prefix_bind ~default: "" in
    let header = "# Generated by BetterTmux" in
    let content = append_lines header [binds; prefix] in
    Out_channel.write_all filename_output ~data:content
end

let main =
  let json = Yojson.Safe.from_file filename in
  let parsed = TmuxConfig.of_yojson json in
  match parsed with
  | Ok config -> (
    try Printer.print config with InvalidKey message -> print_endline message )
  | Error error ->
      print_endline ("⚠️  Error whilte trying to parse tmux.json: " ^ error)
;;

main
