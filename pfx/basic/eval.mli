open Ast

type args = Int of int | InstructionSeq of command list

val eval_program: Ast.program -> args list -> unit
