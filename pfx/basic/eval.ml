open Ast
open Printf

let string_of_stack stack = sprintf "[%s]" (String.concat ";" (List.map string_of_int stack))

let string_of_state (cmds,stack) =
  (match cmds with
   | [] -> "no command"
   | cmd::_ -> sprintf "executing %s" (string_of_command cmd))^
    (sprintf " with stack %s" (string_of_stack stack))

(* Question 4.2 *)
(* Auteur : Nicolas Sempéré 
   Implémentation des petits pas des séquences d'instruction*)
let step state =
  match state with

  | Push v:: q , stack            -> Ok (q, v::stack)
  
  | Pop :: q , _v::stack          -> Ok (q, stack)
  | Pop :: _q , []                 -> Error("Stack is empty. Can't pop", state)

  | Swap :: q , v1::v2::stack     -> Ok (q, v2::v1::stack)
  | Swap :: _q , []                -> Error("Stack is empty. Can't swap", state)
  | Swap :: _q , _v1::[]            -> Error("Stack has only one element. Can't swap", state)
  
  | Add :: q , v1::v2::stack    -> Ok (q, (v1+v2)::stack)
  | Add :: _q , []                -> Error("Stack is empty. Can't add.", state)
  | Add :: _q , _v1::[]            -> Error("Stack has only one element. Can't add", state)
  
  | Sub :: q , v1::v2::stack    -> Ok (q, (v1-v2)::stack)
  | Sub :: _q , []                -> Error("Stack is empty. Can't substract", state)
  | Sub :: _q , _v1::[]            -> Error("Stack has only one element. Can't substract", state)
  
  | Mul :: q , v1::v2::stack    -> Ok (q, (v1*v2)::stack)
  | Mul :: _q , []                -> Error("Stack is empty. Can't multiply", state)
  | Mul :: _q , _v1::[]            -> Error("Stack has only one element. Can't multiply", state)
  
  | Div :: _q , _v1::0::_stack         -> Error("Division by 0", state)
  | Div :: q , v1::v2::stack    -> Ok (q, (v1/v2)::stack)
  | Div :: _q , []                -> Error("Stack is empty. Can't divide", state)
  | Div :: _q , _v1::[]            -> Error("Stack has only one element. Can't divide", state)
  
  | Rem :: _q , _v1::0::_stack         -> Error("Division by 0", state)
  | Rem :: q , v1::v2::stack    -> Ok (q, (v1 mod v2)::stack)
  | Rem :: _q , []                -> Error("Stack is empty. Can't calculate the remainder", state)
  | Rem :: _q , _v1::[]            -> Error("Stack has only one element. Can't calculate the remainder", state)
  
  | [], _ -> Error("Nothing to step",state)

let eval_program (numargs, cmds) args =
  let rec execute = function
    | [], []    -> Ok None
    | [], v::_  -> Ok (Some v)
    | state ->
       begin
         match step state with
         | Ok s    -> execute s
         | Error e -> Error e
        end
  in
  if numargs = List.length args then
    match execute (cmds,args) with
    | Ok None -> printf "No result\n"
    | Ok(Some result) -> printf "= %i\n" result
    | Error(msg,s) -> printf "Raised error '%s' in state %s\n" msg (string_of_state s)
  else printf "Raised error \nMismatch between expected and actual number of args\n"
;;
(* Fonction de tests unitaires de eval.ml*)
(*
let () =
  print_endline("Quelques tests unitaires de l'implémentation du type 'command' et de la fonction 'step'.");;
  let q = [Push 4; Push 55; Push 432; Pop; Pop; Pop; Pop; Pop; Pop];; let stack = [42;4242;249384729742];;
  (*printf "q est de taille %i \n" (List.length q);;*)
  printf "\n Test 1 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;
  let q = [Pop; Push 2; Pop;];; let stack = [42;24];;
  printf "\n Test 2 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;
  let q = [Pop;];; let stack = [];;
  printf "\n Test 3 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [];; let stack = [];;
  printf "\n Test 4 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Add];; let stack = [];;
  printf "\n Test 5 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Push 2; Push 3; Add];; let stack = [];;
  printf "\n Test 6 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Push 12; Push 7; Sub];; let stack = [];;
  printf "\n Test 7 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Push 12; Push 7; Swap; Sub];; let stack = [];;
  printf "\n Test 8 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Mul];; let stack = [77; 88; 4; 2];;
  printf "\n Test 9 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Div];; let stack = [77; 88; 4; 2];;
  printf "\n Test 10 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Div];; let stack = [77; 0; 88; 2];;
  printf "\n Test 11 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Add; Div];; let stack = [3; 7; 2];;
  printf "\n Test 12 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Rem];; let stack = [3; 0; 2];;
  printf "\n Test 13 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Rem];; let stack = [10; 3];;
  printf "\n Test 14 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;
  
  let q = [Push 1; Push 5; Div];; let stack = [];;
  printf "\n Test 15 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;
  
  let q = [Push 3; Push 7; Rem];; let stack = [];;
  printf "\n Test 16 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Push 2; Push 7; Push 3; Add; Div];; let stack = [];;
  printf "\n Test 17 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;
  *)