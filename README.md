Auteur
-------

- Nicolas Sempéré

===============

Description du projet
--------------------------

Ce μ-projet est un compilateur simple

===============

Sources : Pdf présentant le projet (cf "compilation-project")
-------

Repo git : https://github.com/TanatornG/projet-compil.git

Version : 1.0 - Exercice 4

===============

Comment...
-------

... récupérer le code source

  git clone https://github.com/TanatornG/projet-compil.git

... compiler, exécuter et tester le projet ?

  A l'exercice 4, on ne s'intéresse qu'aux fichiers ast.ml et eval.ml.
  Une fonction contenant des tests unitaires est implémentée dans eval.ml.
  Pour lancer ces tests :
  - ocamlopt -c ast.mli
  - ocamlopt -c ast.ml
  - ocamlopt -c eval.mli
  - ocamlopt -c eval.ml
  - ocamlopt -o ex4 ast.ml eval.ml
  - ./ex4

===============

Structure du projet
------------------------

Le projet suit l'organisation suivante :

Arbre du projet :

project

---- README

---- dune-project

---- expr: the expr compiler

│   ---- README

│   ---- basic

│   │   ---- ast.ml

│   │   ---- ast.mli

│   │   ---- dune

│   │   ---- eval.ml

│   │   ---- eval.mli

│   │   ---- lexer.mll

│   │   ---- parser.mly

│   │   ---- tests: for tests

│   │      ---- an_example.expr

│   │   ---- toPfx.ml             <- To edit

│   │   ---- toPfx.mli

│   ---- common

│   │   ---- binOp.ml

│   │   ---- binOp.mli

│   │   ---- dune

│   ---- compiler.ml: main file for the expr compiler

│   ---- dune

│   ---- fun: the expr parser for section 7

│   │   ---- ast.ml

│   │   ---- ast.mli

│   │   ---- lexer.mll

│   │   ---- parser.mly

│   ---- main.ml

---- pfx: the pfx VM

│   ---- basic

│   │   ---- ast.ml               <- Implémentation faite (Question 4.1)

│   │   ---- ast.mli

│   │   ---- dune

│   │   ---- eval.ml              <- Implémentation faite (Question 4.2)

│   │   ---- eval.mli

│   │   ---- lexer.mll            <- To edit

│   │   ---- parser.mly           <- To edit

│   │   ---- tests: for tests

│   │       ---- ok_prog.pfx

│   ---- pfxVM.ml: main file for the pfx VM

---- utils

    ---- dune

    ---- location.ml: module offering a data type for a location in a file

    ---- location.mli
===============

Avancée du projet
--------

- Implémentation d'une calculatrice simple en OCaml.
Voir les fichiers :
 - project/pfx/basic/ast.ml
 - project/pfx/basic/eval.ml

 Les 14 tests unitaires réalisés dans eval.ml sont corrects (le comportement du programme est celui attendu).

===============

Problèmes et bugs connus
--------------------

- Pas de bugs à la question 4 (implémentation d'une calculatrice simple)
===============

Ressources utiles
-----------------

===============

Difficultés
------------

Absolument aucune car je suis trop fort ;)

