type bind = { key : string list; command : string } [@@deriving yojson]
type binds = bind list [@@deriving yojson]

type t = { prefix : string list option; binds : binds option }
[@@deriving yojson]

let from_json = of_yojson
