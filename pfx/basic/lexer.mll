  {
  open Utils
  (*open Parser*)
  type token =
    | EOF | PUSH | POP | SWAP | ADD | SUB | MUL | DIV | REM
    | INT of int

  let print_token = function
    | EOF -> print_string "EOF"
    | PUSH -> print_string "PUSH"
    | POP -> print_string "POP"
    | SWAP -> print_string "SWAP"
    | ADD -> print_string "ADD"
    | SUB -> print_string "SUB"
    | MUL -> print_string "MUL"
    | DIV -> print_string "DIV"
    | REM -> print_string "REM"
    | INT i -> print_int i

  let mk_int nb lexbuf =
    try INT (int_of_string nb)
    with Failure _ -> failwith (Location.string_of (Location.curr lexbuf ))
}

let newline = (['\n' '\r'] | "\r\n")
let blank = [' ' '\014' '\t' '\012']
let not_newline_char = [^ '\n' '\r']
let digit = ['0'-'9']

rule token = parse
  (* newlines *)
  | newline { token lexbuf }
  (* blanks *)
  | blank + { token lexbuf }
  (* end of file *)
  | eof      { EOF }
  (* comments *)
  | "--" not_newline_char*  { token lexbuf }
  (* integers *)
  | digit+ as nb           { mk_int nb lexbuf }
  (* Question 6.1 *)
  (* commands  *)(***** TO COMPLETE *****)
  | "push"    { PUSH }
  | "pop"     { POP }
  | "swap"    { SWAP }
  | "add"     { ADD }
  | "sub"     { SUB }
  | "mul"     { MUL }
  | "div"     { DIV }
  | "rem"     { REM }

  (* illegal characters *)
  | _ as c                  { failwith (Printf.sprintf "Illegal character '%c': " c ^Location.string_of (Location.curr lexbuf )) }

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