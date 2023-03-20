%{
  open Ast
%}

(**************
 * The tokens *
 **************)

%token EOF PUSH POP SWAP ADD SUB MUL DIV REM NEWLINE EXEC GET
%token <int> INT


(******************************
 * Entry points of the parser *
 ******************************)

(* enter your %start clause here *)
%start <Ast.program list> programs

%%





(*************
 * The rules *
 *************)

programs:
  | p=program + { p }
program: 
  | i=INT; c=cmd { i, c }
  

cmd: 
  | PUSH cmd { failwith ("Argument missing for push function") }
  | PUSH i=INT c=cmd { (Push i)::c }
  | POP c=cmd { Pop::c }
  | SWAP c=cmd { Swap::c }
  | ADD c=cmd { Add::c }
  | SUB c=cmd { Sub::c }
  | MUL c=cmd { Mul::c }
  | DIV c=cmd { Div::c }
  | REM c=cmd { Rem::c }
  | EXEC c=cmd { Exec::c }
  | GET c=cmd { Get::c }
  | EOF { [] }
  | NEWLINE { [] }


%%
