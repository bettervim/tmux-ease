exception InvalidTomlConfiguration of string
exception InvalidFileFormat of string

type options = {
  historyLimit : int option;
  statusKeys : string option;
  modeKeys : string option;
  setTitles : string option;
  setTitlesString : string option;
}
[@@deriving yojson]

type bind = { key : string list; command : string } [@@deriving yojson]
type binds = bind list [@@deriving yojson]

type t = {
  prefix : string list option;
  binds : binds option;
  options : options;
}
[@@deriving yojson]

module TomlParser = struct
  let prefix data =
    let open Toml.Lenses in
    get data (key "prefix" |-- array |-- strings)

  let bind data =
    let open Toml.Lenses in
    let command = get data (key "command" |-- string) in
    let key = get data (key "key" |-- array |-- strings) in
    match (key, command) with
    | Some key, Some command -> { key; command }
    | Some _, None ->
        raise
          (InvalidTomlConfiguration
             "⚠️  The field 'key' wasn't provided. Check your list of bindings")
    | None, Some _ ->
        raise
          (InvalidTomlConfiguration
             "⚠️  The field 'command' wasn't provided. Check your list of \
              bindings.")
    | None, None ->
        raise
          (InvalidTomlConfiguration
             "⚠️  Both keys 'key' and 'command' weren't provided. Check your \
              list of bindings.")

  let binds data =
    let open Toml.Lenses in
    let raw_binds = get data (key "binds" |-- array |-- tables) in
    raw_binds |> Core.Option.map ~f:(Core.List.map ~f:bind)

  let options data =
    let open Toml.Lenses in
    let table_opts = get data (key "options" |-- table) in
    match table_opts with
    | None ->
        {
          statusKeys = None;
          historyLimit = None;
          modeKeys = None;
          setTitles = None;
          setTitlesString = None;
        }
    | Some table ->
        let historyLimit = get table (key "history-limit" |-- int) in
        let statusKeys = get table (key "status-keys" |-- string) in
        let modeKeys = get table (key "mode-keys" |-- string) in
        let setTitles = get table (key "set-titles" |-- string) in
        let setTitlesString = get table (key "set-titles-string" |-- string) in
        { statusKeys; historyLimit; modeKeys; setTitles; setTitlesString }
end

let from_json filename =
  match Yojson.Safe.from_file filename |> of_yojson with
  | Ok data -> Result.Ok data
  | Error message -> Result.Error message

let from_toml filename =
  let result = Toml.Parser.from_filename filename in
  match result with
  | `Ok data ->
      Result.Ok
        {
          prefix = TomlParser.prefix data;
          binds = TomlParser.binds data;
          options = TomlParser.options data;
        }
  | `Error (_, _) -> Result.Error "Failed to parse"

let from_file filename =
  let file_extension =
    filename |> Core.String.split ~on:'.' |> Core.List.last
  in
  match file_extension with
  | Some "json" -> from_json filename
  | Some "toml" -> from_toml filename
  | _ -> raise (InvalidFileFormat ("Invalid file format: " ^ filename))
