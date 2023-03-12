Auteur
-------

- Nicolas Sempéré

===============

Description du projet
--------------------------

Ce μ-projet est un compilateur simple

===============

Sources
-------

Git repository: https://redmine-df.telecom-bretagne.eu/git/PROJECTNAME

Release : tag 1.0 

===============

How to…
-------

…retrieve the sources?

  git clone https://redmine-df.telecom-bretagne.eu/git/PROJECTNAME

…compile?

  dune …

…execute and test?

  dune utop and then use the libraries
  (from project root) dune exec expr/main.exe -- expr/basic/tests/an_example.expr
  dune exec ./pfxVM.exe -- TESTFILE.pfx -a 12 -a 52

===============

Structure du projet
------------------------

Le projet suit l'organisation suivante :

Arbre du projet :

project
├── README
├── dune-project
├── expr: the expr compiler
│   ├── README
│   ├── basic
│   │   ├── ast.ml
│   │   ├── ast.mli
│   │   ├── dune
│   │   ├── eval.ml
│   │   ├── eval.mli
│   │   ├── lexer.mll
│   │   ├── parser.mly
│   │   ├── tests: for tests
│   │   │   └── an_example.expr
│   │   ├── toPfx.ml             <- To edit
│   │   └── toPfx.mli
│   ├── common
│   │   ├── binOp.ml
│   │   ├── binOp.mli
│   │   └── dune
│   ├── compiler.ml: main file for the expr compiler
│   ├── dune
│   ├── fun: the expr parser for section 7
│   │   ├── ast.ml
│   │   ├── ast.mli
│   │   ├── lexer.mll
│   │   └── parser.mly
│   └── main.ml
├── pfx: the pfx VM
│   ├── basic
│   │   ├── ast.ml               <- Implémentation faite (Question 4.1)
│   │   ├── ast.mli
│   │   ├── dune
│   │   ├── eval.ml              <- Implémentation faite (Question 4.2)
│   │   ├── eval.mli
│   │   ├── lexer.mll            <- To edit
│   │   ├── parser.mly           <- To edit
│   │   └── tests: for tests
│   │       └── ok_prog.pfx
│   └── pfxVM.ml: main file for the pfx VM
└── utils
    ├── dune
    ├── location.ml: module offering a data type for a location in a file
    └── location.mli
===============

Avancée du projet
--------

- Implémentation d'une calculatrice simple en OCaml.
Voir les fichiers :
 - project/pfx/basic/ast.ml
 - project/pfx/basic/eval.ml

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

