exception RuntimeError of string

val eval : (string * int) list -> Ast.expression -> int
