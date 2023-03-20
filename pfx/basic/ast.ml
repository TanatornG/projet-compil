open Printf
(* Auteur : Nicolas Sempéré
Il y a trois instructions basiques : push, pop et swap.
Il y a cinq opérations arithmétiques : add, sub, mul, div et rem.*)
type command =
  | Push of int 
  | Pop 
  | Swap 
  | Add 
  | Sub 
  | Mul 
  | Div 
  | Rem 
  | Exec 
  | Get 
  | InstructionSeq of command list

type program = int * command list

(* add here all useful functions and types related to the AST: for instance string_of_functions *)

let rec string_of_command cmd = match cmd with
| Push v-> sprintf "Push %i" v
| Pop -> "Pop"
| Swap -> "Swap"
| Add -> "Add"
| Mul -> "Mul"
| Sub-> "Sub"
| Div -> "Div"
| Rem -> "Rem"
| Exec -> "Exec"
| Get -> "Get"
| InstructionSeq cmds -> sprintf "[%s]" (String.concat ";" (List.map string_of_command cmds))

let string_of_commands cmds = sprintf "[%s]" (String.concat ";" (List.map string_of_command cmds))

let string_of_program (args, cmds) = Printf.sprintf "%i args: %s\n" args (string_of_commands cmds)

