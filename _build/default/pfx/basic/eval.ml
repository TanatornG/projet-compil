open Ast
open Printf

let string_of_stack stack = sprintf "[%s]" (String.concat ";" (List.map string_of_int stack))

let string_of_state (cmds,stack) =
  (match cmds with
   | [] -> "no command"
   | cmd::_ -> sprintf "executing %s" (string_of_command cmd))^
    (sprintf " with stack %s" (string_of_stack stack))

(* Question 4.2 *)
(* Auteur : Nicolas Sempéré *)
let step state =
  match state with
  (* Valid configurations *)
  | Push v:: q , stack          -> Ok (q, v::stack)
  | Pop :: q , _v::stack        -> Ok (q, stack)
  | Swap :: q , v1::v2::stack   -> Ok (q, v2::v1::stack)
  | Add :: q , v1::v2::stack    -> Ok (q, (v1+v2)::stack)
  | Sub :: q , v1::v2::stack    -> Ok (q, (v1-v2)::stack)
  | Mul :: q , v1::v2::stack    -> Ok (q, (v1*v2)::stack)
  | Div :: q , v1::v2::stack    -> Ok (q, (v1/v2)::stack)
  | Rem :: q , v1::v2::stack    -> Ok (q, (v1 mod v2)::stack)
  
  (* Errors *)
  | [], _ -> Error("Nothing to step",state)
  (**| Push _ :: q , stack           -> Error("Push expects an argument", state)*)
  | Pop :: _ , []              -> Error("Stack is empty. Can't pop", state)


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
    | Error(msg,s) -> printf "Raised error %s in state %s\n" msg (string_of_state s)
  else printf "Raised error \nMismatch between expected and actual number of args\n"
  
  let() =
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