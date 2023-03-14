{
  type token =
    | EOF | PLUS | MINUS | TIMES | DIV | MOD | LPAR | RPAR
    | INT of int | IDENT of string

  let print_token = function
    | EOF -> print_string "EOF"
    | PLUS -> print_string "PLUS"
    | MINUS -> print_string "MINUS"
    | TIMES -> print_string "TIMES"
    | DIV -> print_string "DIV"
    | MOD -> print_string "MOD"
    | LPAR -> print_string "LPAR"
    | RPAR -> print_string "RPAR"
    | INT i -> print_int i
    | IDENT s -> print_string s

  let mk_int nb =
    try INT (int_of_string nb)
    with Failure _ -> failwith (Printf.sprintf "Illegal integer '%s': " nb)
}

let newline = (['\n' '\r'] | "\r\n")
let blank = [' ' '\014' '\t' '\012']
let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']

rule token = parse
  (* newlines *)
  | newline + { token lexbuf }
  (* blanks *)
  | blank + { token lexbuf }
  (* end of file *)
  | eof      { EOF }
  (* integers *)
  | digit+ as nb           { mk_int nb }
  (* commands *)
  | "+"      { PLUS }
  | "-"      { MINUS }
  | "/"      { DIV }
  | "*"      { TIMES }
  | "%"      { MOD }
  | "("      { LPAR }
  | ")"      { RPAR }
  (* identifiers *)
  | letter (letter | digit | '_')* as id { IDENT id }
  (* illegal characters *)
  | _ as c  { failwith (Printf.sprintf "Illegal character '%c': " c) }

{
  let rec examine_all lexbuf =
    let result = token lexbuf in
    print_token result;
    print_string " ";
    match result with
    | EOF -> ()
    | _   -> examine_all lexbuf

  let compile file =
  print_string ("File "^file^" is being treated!\n");
  try
    let input_file = open_in file in
    let lexbuf = Lexing.from_channel input_file in
    examine_all lexbuf;
    print_newline ();
    close_in (input_file)
  with Sys_error _ ->
    print_endline ("Can't find file '" ^ file ^ "'")

  let _ = Arg.parse [] compile ""
}