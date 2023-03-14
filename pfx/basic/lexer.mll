(* Question 6.1 et 6.2 *)
{
  open Utils 
  
  type token = | EOF | INT of int | PUSH | SWAP | POP | ADD | SUB | MUL | DIV | REM

  let print_token = function
    | EOF -> print_string "EOF"
    | INT i -> print_int i
    | PUSH -> print_string "PUSH"
    | SWAP -> print_string "SWAP"
    | POP -> print_string "POP"
    | ADD -> print_string "ADD"
    | SUB -> print_string "SUB"
    | MUL -> print_string "MUL"
    | DIV -> print_string "DIV"
    | REM -> print_string "REM"

  let mk_int nb lexbuf =
    try INT (int_of_string nb)
    with Failure _ -> failwith (Location.string_of (Location.curr lexbuf ) ^ " : illegal integer '" ^ nb ^ "'")
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
  (* commands  *)
  | "push" {PUSH}
  | "pop" {POP}
  | "swap" {SWAP}
  | "add" {ADD}
  | "sub" {SUB}
  | "mul" {MUL}
  | "div" {DIV}
  | "rem" {REM}
  (* illegal characters *)
  | _ as c                 { failwith (Location.string_of (Location.curr lexbuf)^ " : illegal character '" ^ String.make 1 c ^ "'") }

{
  let rec examine_all lexbuf =
    let result = token lexbuf in
    print_token result;
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