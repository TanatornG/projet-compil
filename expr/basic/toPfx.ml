open Ast
open BasicPfx.Ast

(* Auteur : Nicolas Sempéré *)
(* Question 5.2 - Fonction permettant de passer de Expr à Pfx *)
let rec generate = function
  | Const v -> [Push v]
  | Binop(Badd,expr1,expr2) ->  (generate expr2)@(generate expr1)@[Add]
  | Binop(Bsub,expr1,expr2) ->  (generate expr2)@(generate expr1)@[Sub]
  | Binop(Bmul,expr1,expr2) ->  (generate expr2)@(generate expr1)@[Mul]
  | Binop(Bdiv,expr1,expr2) ->  (generate expr2)@(generate expr1)@[Div]
  | Binop(Bmod,expr1,expr2) ->  (generate expr2)@(generate expr1)@[Rem]
  | Uminus expr ->  (generate expr)@[Push 0]@[Sub]
  | Var _ ->  [Push 0; Pop] (* A implémenter : Push 0 - Pop revient à ne rien faire*)
