open Ast
open Printf


type args = Int of int | InstructionSeq of command list
let rec string_of_stack stack = match stack with
  | [] -> ""
  | (Int i)::s -> (string_of_int i)^" " ^ string_of_stack s
  | (InstructionSeq seq)::s -> (string_of_commands seq) ^ string_of_stack s

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
    | (Push x)::q, stack -> Ok (q, (Int x)::stack)

    | Pop::_, [] -> Error("Stack is empty. Can't pop", state)
    | Pop::q, _::stack -> Ok (q, stack)
    
    | Swap::_, _::[] -> Error("Stack is empty. Can't swap", state)
    | Swap::_, [] -> Error("Stack has only one element. Can't swap", state)
    | Swap::q, x::y::stack -> Ok (q, y::x::stack)

    | Add::_, _::[] -> Error("Stack is empty. Can't add", state)
    | Add::_, [] -> Error("Stack has only one element. Can't add", state)
    | Add::_, (InstructionSeq _)::_ -> Error("Wrong type", state)
    | Add::_, _::(InstructionSeq _)::_ -> Error("Wrong type", state)
    | Add::q, (Int x)::(Int y)::stack -> Ok (q, (Int (x + y))::stack)

    | Sub::_, _::[] -> Error("Stack is empty. Can't Sub", state)
    | Sub::_, [] -> Error("Stack has only one element. Can't Sub", state)
    | Sub::_, (InstructionSeq _)::_ -> Error("Wrong type", state)
    | Sub::_, _::(InstructionSeq _)::_ -> Error("Wrong type", state)
    | Sub::q, (Int x)::(Int y)::stack -> Ok (q, (Int (x - y))::stack)

    | Mul::_, _::[] -> Error("Stack is empty. Can't mul", state)
    | Mul::_, [] -> Error("Stack has only one element. Can't mul", state)
    | Mul::_, (InstructionSeq _)::_ -> Error("Wrong type", state)
    | Mul::_, _::(InstructionSeq _)::_ -> Error("Wrong type", state)
    | Mul::q, (Int x)::(Int y)::stack -> Ok (q, (Int (x * y))::stack)

    | Div::_, _::[] -> Error("Stack is empty. Can't div", state)
    | Div::_, [] -> Error("Stack has only one element. Can't div", state)
    | Div::_, _::(Int 0)::_ -> Error("Forbidden operation",state)
    | Div::_, (InstructionSeq _)::_ -> Error("Wrong type", state)
    | Div::_, _::(InstructionSeq _)::_ -> Error("Wrong type", state)
    | Div::q, (Int x)::(Int y)::stack -> Ok (q, (Int (x / y))::stack)

    | Rem::_, _::[] -> Error("Stack is empty. Can't rem", state)
    | Rem::_, [] -> Error("Stack has only one element. Can't rem", state)
    | Rem::_, _::(Int 0)::_ -> Error("Forbidden operation",state)
    | Rem::_, (InstructionSeq _)::_ -> Error("Wrong type", state)
    | Rem::_, _::(InstructionSeq _)::_ -> Error("Wrong type", state)
    | Rem::q, (Int x)::(Int y)::stack -> Ok (q, (Int (x mod y))::stack)

    | Get::_, (Int i)::stack when (List.length stack) < i -> Error("Invalid get operation", state)
    | Get::_, (Int i)::_ when i < 0 -> Error("Cannot get negative index", state)
    | Get::_, [] -> Error("Stack is empty. Nothing to get", state)
    | Get::_, (InstructionSeq _)::_ -> Error("Wrong type", state)
    | Get::q, (Int i)::stack -> Ok (q, (List.nth stack i)::stack)

    | Exec::_, [] -> Error("Nothing to exec", state)
    | Exec::_, (Int _)::_ -> Error("Wrong type", state)
    | Exec::q, (InstructionSeq s)::stack -> Ok (s @ q, stack)
    
    | (InstructionSeq s)::q, stack -> Ok (q, (InstructionSeq s)::stack)

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
    | Ok(Some result) -> 
      begin
        match result with
            | Int x -> printf "= %i\n" x
            | InstructionSeq _ -> printf "No result\n"
        end
    | Error(msg,s) -> printf "Raised error %s in state %s\n" msg (string_of_state s)
  else printf "Raised error \nMismatch between expected and actual number of args\n"
;;
(* Fonction de tests unitaires de eval.ml*)

let () =
  print_endline("Quelques tests unitaires de l'implémentation du type 'command' et de la fonction 'step'.");;


  let q = [Push 2; Push 7; Push 3; Add; Div];; let stack = [];;
  printf "\n Test 1 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  (* Tests InstructionSeq *)
  let q = [Exec;];; let stack = [InstructionSeq [Push 2; Push 7; Push 3; Add; Div]];;
  printf "\n Test 2 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

  let q = [Exec; Add;];; let stack = [InstructionSeq [Push 2; Push 7; Push 3; Add; Div]; Int 5];;
  
  printf "\n Test 3 : %s %s \n" (string_of_commands q)(string_of_stack stack);;
  eval_program (List.length(stack), q) stack;;

