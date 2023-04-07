Auteurs
-------

- Squelette du projet : IMT Atlantique
- Amaury Coudray
- Nicolas Sempéré

===============

Description du projet
--------------------------

Ce μ-projet est un compilateur simple

===============

Sources : Pdf présentant le projet (cf "compilation-project")
-------

Repo git : https://github.com/TanatornG/projet-compil.git

Version : 6.0 - Exercice 9

===============

Comment...
-------

... récupérer le code source

  git clone https://github.com/TanatornG/projet-compil.git

... compiler, exécuter et tester le projet ?

  A l'exercice 4, on ne s'intéresse qu'aux fichiers ast.ml et eval.ml du dossier pfx/basic.
  Une fonction contenant des tests unitaires est implémentée dans eval.ml.
  La fonction de test, commençant par "let() = ..." a été mise en commentaire
  car elle se lance automatiquement.
  Pour lancer ces tests :
  - 1 - cd pfx/basic
  - 2 - ocamlopt -c ast.mli
  - 3 - ocamlopt -c ast.ml
  - 4 - ocamlopt -c eval.mli
  - 5 - ocamlopt -c eval.ml
  - 6 - ocamlopt -o ex4 ast.ml eval.ml
  - 7 - ./ex4

  A l'exercice 5, on implémente un compilateur simple de Expr vers Pfx.
  La fonction "generate", du fichier toPfx.ml, dans le dossier expr/basic, implémente le schéma de compilation (cf question 5.1).

  Le compilateur fonctionne comme attendu.
  On peut : traduire une expression du type "(5+6) * (9/3)" de Expr vers Pfx.
  Les opérateurs autorisés sont : "+, -, *, /, \%, uminus" (uminus permet de prendre l'opposé d'un nombre)

  Pour vérifier le fonctionnement du compilateur :
  - 1 - Ecrire l'expression arithmétique à tester dans le fichier project/expr/basic/tests/an_example.expr
  - 2 - dune exec ./compiler.exe -- basic/tests/an_example.expr

  A l'exercice 6, on implémente un lexer de Pfx.
  Il se trouve dans le dossier pfx/basic/lexer.mll et fonctionne comme attendu.
  Pour le tester (via utop) : 
  - 1 - cd pfx/basic 
  - 2 - ocamllex lexer.mll 
  - 3 - utop 
  - 4 - #use "lexer.ml";;
  - 5 - let buffer = Lexing.from\_string "0 push 2 push 7 push 3 add div -- -5" ;;
  - 6 - token buffer;; (à répéter jusqu'à atteindre la fin de la ligne).
  Le lexer fonctionne comme prévu, il reconnait les tokens suivant :
  "| EOF | PUSH | POP | SWAP | ADD | SUB | MUL | DIV | REM | INT |".

  A l'exercice 7, on implémente des messages d'erreur avec position dans le lexer.
  On utilise le fichier /utils/location.ml dans le lexer Pfx (pfx/basic/lexer.mll).
  Pour tester :
  - 1 - cd pfx/basic
  - 2 - dune exec ./lexer.exe – ./tests/ok_prog.pfx

  A l'exercice 8, on implémente un parser de pfx.
  Pour tester : 
  - 1 - cd pfx/basic
  - 2 - dune exec ./pfx/pfxVM.exe – ./pfx/basic/tests/okprog.pfx

  A l'exercice 9

===============

Structure du projet
------------------------

Le projet suit l'organisation suivante :

Arbre du projet :

project :

  - README.md

  - dune-project

  - compilation-project.pdf

  - expr: the expr compiler
    - README
    - basic
      - ast.ml
      - ast.mli
      - dune
      - eval.ml
      - eval.mli
      - lexer.mll
      - parser.mly
      - tests: for tests
       - an_example.expr
      - toPfx.ml             <- Implémentation faite (Question 5.2)
      - toPfx.mli
    - common
      - binOp.ml
      - binOp.mli
      - dune
    - compiler.ml: main file for the expr compiler
    - dune
    - fun: the expr parser for section 7
      - ast.ml
      - ast.mli
      - lexer.mll
      - parser.mly
    - main.ml

  - pfx: the pfx VM
    - basic
      - ast.ml               <- Implémentation faite (Question 4.1)
      - ast.mli
      - dune
      - eval.ml              <- Implémentation faite (Question 4.2)
      - eval.mli
      - lexer.mll            <- Implémentation faite (Question 6.1 et 6.2)
      - parser.mly           <- Implémentation faite (Question 8.1 et 8.2)
      - tests: for tests
        - ok_prog.pfx
    - pfxVM.ml: main file for the pfx VM
    - dune
    - utils
      - dune
      - location.ml: module offering a data type for a location in a file
      - location.mli

===============

Avancée du projet
--------

- Questions 4.1 et 4.2 : Implémentation d'une calculatrice simple en OCaml (cf dossier pfx/basic)
Voir les fichiers :
 - pfx/basic/ast.ml
 - pfx/basic/eval.ml

Les 14 tests unitaires réalisés dans eval.ml sont corrects (le comportement du programme est celui attendu).

- Question 5.2 : Implémentation d'un compilateur simple de Expr vers Pfx.
Voir le fichier :
 - expr/basic/tests/an_example.expr

Tous les tests passés (en évaluant diverses expressions arithmétiques) sont corrects.

- Question 6.1 et 6.2 : Implémentation d'un lexer de Pfx.
Voir le fichier :
 - pfx/basic/lexer.mll

- Question 7 : Implémentation de la localisation d'erreur du lexer de Pfx.

- Question 8 : Implémentation d'un parser de Pfx.
Voir le fichier :
 - pfx/basic/parser.mly

- Question 9

Tous les tests passés (en Lexant diverses expressions de Pfx) sont corrects.

===============

Problèmes et bugs connus
--------------------

- Pas de bugs à la question 4 (implémentation d'une calculatrice simple)
- Pas de bugs à la question 5 (implémentation d'un compilateur simple)
- Pas de bugs à la question 6 (implémentation d'un lexer de Pfx)
- Pas de bugs à la question 7 (implémentation d'une localisation d'erreurs de Pfx)
- Pas de bugs à la question 8 (implémentation d'un parser de Pfx)
- Pas de bugs à la question 9

===============

Ressources utiles
-----------------

===============

Difficultés
------------