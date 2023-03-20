open Ast

type argsType = Int of int | InstructionSeq of command list

val eval_program: Ast.program -> argsType list -> unit
