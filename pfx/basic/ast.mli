(* The type of the commands for the stack machine *)
type command =
  (* Question 4.1 *)
  | Push of int
  | Pop
  | Swap
  | Add
  | Sub
  | Mul
  | Div
  | Rem
  
(* The type for programs *)
type program = int * command list

(* Converting a command to a string for printing *)
val string_of_command : command -> string

(* Converting a list of commands to a string for printing *)
val string_of_commands : command list -> string

(* Converting a program to a string for printing *)
val string_of_program : program -> string
