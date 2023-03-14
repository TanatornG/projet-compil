# 1 "lexer.mll"
   
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

  let mk_int nb =
    try INT (int_of_string nb)
    with Failure _ -> failwith (Printf.sprintf "Illegal integer '%s': " nb)

# 25 "lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\242\255\000\000\000\000\000\000\002\000\001\000\002\000\
    \010\000\001\000\253\255\006\000\255\255\001\000\006\000\004\000\
    \006\000\000\000\250\255\249\255\000\000\002\000\010\000\248\255\
    \246\255\003\000\247\255\000\000\245\255\005\000\244\255\001\000\
    \243\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\013\000\013\000\013\000\013\000\013\000\013\000\
    \004\000\013\000\255\255\001\000\255\255\000\000\003\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255";
  Lexing.lex_default =
   "\001\000\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\255\255\000\000\255\255\014\000\255\255\
    \255\255\255\255\000\000\000\000\255\255\255\255\255\255\000\000\
    \000\000\255\255\000\000\255\255\000\000\255\255\000\000\255\255\
    \000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\011\000\012\000\012\000\011\000\013\000\011\000\011\000\
    \255\255\000\000\011\000\255\255\011\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \011\000\000\000\000\000\000\000\000\000\000\000\011\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\009\000\014\000\000\000\
    \008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\008\000\008\000\008\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\005\000\024\000\022\000\003\000\031\000\025\000\026\000\
    \018\000\029\000\000\000\000\000\028\000\004\000\032\000\000\000\
    \007\000\015\000\002\000\006\000\019\000\027\000\020\000\016\000\
    \021\000\017\000\023\000\030\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \010\000\000\000\000\000\000\000\000\000\000\000\255\255\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\013\000\000\000\000\000\000\000\011\000\
    \014\000\255\255\011\000\014\000\011\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\011\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\000\000\009\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\008\000\008\000\008\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\020\000\021\000\000\000\002\000\005\000\025\000\
    \017\000\003\000\255\255\255\255\027\000\000\000\031\000\255\255\
    \000\000\007\000\000\000\000\000\015\000\004\000\006\000\007\000\
    \006\000\016\000\022\000\029\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\014\000\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec token lexbuf =
   __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 31 "lexer.mll"
            ( token lexbuf )
# 136 "lexer.ml"

  | 1 ->
# 33 "lexer.mll"
            ( token lexbuf )
# 141 "lexer.ml"

  | 2 ->
# 35 "lexer.mll"
             ( EOF )
# 146 "lexer.ml"

  | 3 ->
# 37 "lexer.mll"
                            ( token lexbuf )
# 151 "lexer.ml"

  | 4 ->
let
# 39 "lexer.mll"
              nb
# 157 "lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 39 "lexer.mll"
                           ( mk_int nb )
# 161 "lexer.ml"

  | 5 ->
# 42 "lexer.mll"
              ( PUSH )
# 166 "lexer.ml"

  | 6 ->
# 43 "lexer.mll"
              ( POP )
# 171 "lexer.ml"

  | 7 ->
# 44 "lexer.mll"
              ( SWAP )
# 176 "lexer.ml"

  | 8 ->
# 45 "lexer.mll"
              ( ADD )
# 181 "lexer.ml"

  | 9 ->
# 46 "lexer.mll"
              ( SUB )
# 186 "lexer.ml"

  | 10 ->
# 47 "lexer.mll"
              ( MUL )
# 191 "lexer.ml"

  | 11 ->
# 48 "lexer.mll"
              ( DIV )
# 196 "lexer.ml"

  | 12 ->
# 49 "lexer.mll"
              ( REM )
# 201 "lexer.ml"

  | 13 ->
let
# 52 "lexer.mll"
         c
# 207 "lexer.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 52 "lexer.mll"
                            ( failwith (Printf.sprintf "Illegal character '%c': " c) )
# 211 "lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

;;

# 54 "lexer.mll"
 
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

# 241 "lexer.ml"
