# Démo


- [Démo](#démo)
  - [Objectifs](#objectifs)
  - [Situation initiale](#situation-initiale)
  - [Qu'est ce qu'une librairie partagée (shared library) ?](#quest-ce-quune-librairie-partagée-shared-library-)
  - [Créer la librairie partagée](#créer-la-librairie-partagée)
  - [Utiliser la librairie dynamique dans son projet](#utiliser-la-librairie-dynamique-dans-son-projet)
    - [Compiler (compilation et assemblage)](#compiler-compilation-et-assemblage)
    - [Linker](#linker)
  - [Changer d'implémentation par une autre à l'execution](#changer-dimplémentation-par-une-autre-à-lexecution)
  - [Créer un executable *standalone* : *dynamic library* vs *static library*](#créer-un-executable-standalone--dynamic-library-vs-static-library)
  - [Lien avec Flutter : Comment Flutter peut build du multi-natif à partir d'une même codebase ?](#lien-avec-flutter--comment-flutter-peut-build-du-multi-natif-à-partir-dune-même-codebase-)
  - [Utiliser le Makefile](#utiliser-le-makefile)
  - [Liens utiles](#liens-utiles)


## Objectifs

- Comprendre la phase de *linkage* avec des librairies (fournie par la plateforme ou les nôtres);
- Créer et distribuer sa propre librairie partagée (*shared library*);
- Comment changer d'implémentation à l'execution;
- Comprendre comment Flutter est capable de construire des executables (binaires) pour chaque plateforme grâce, notamment, aux libraires partagées.

## Situation initiale

> On parlera indistinctement de "*library*", "librairie" ou "bibliothèque". On parle souvent de "librairie" en français malgré le fait que la traduction correcte de library soit "bibliothèque". Néanmoins, le mot librairie est plus court et c'est un faux ami qui permet de faire la correspondance du concept dans les deux langues.

Nous avons une *library* `student`,du code, que nous souhaiterions distribuer. Ce code fournit une structure de données et des fonctions pour travailler sur des étudiant·es (système d'info d'une école par exemple). 

Si nous voulons *distribuer* ce code, nous n'allons distribuer que le header (`student.h`) et le binaire, et non le code source de l'implémentation (`student.c`), car l'utilisateur n'a pas à la connaître pour s'en servir. C'est ce qu'on appelle **l’encapsulation** (la même encapsulation qu'en POO !). Il a seulement besoin de connaître les *déclarations* et signatures de mes fonctions(l'*API* de ma library).

Pour cela, je vais donc distribuer aux utilisateur·ices :

- Le header `student.h`, pour que l'utilisateur connaisse les signatures des fonctions et puisse s'en servir dans son propre code;
- Mon implémentation compilée sous forme de librairie partagée (*shared library*) (`.so`)

## Qu'est ce qu'une librairie partagée (shared library) ?

Une librairie partagée (aussi appelée *dynamic library*) est un *fichier objet* (binaire, *code source compilé*). Sous Unix, les shared libraries sont appelées *shared object* (d'où l'extension `.so`), sous Windows elles sont appelées *dynamic link libraries* (ou DLLs, d'où l'extension `.dll`). Cela permet de partager des implémentations sous forme de binaire : fonctions, structures de données, etc.. 

Le code ainsi compilé peut être utilisé *par plusieurs programmes en même temps* (d'où le *shared library*). La librairie partagée est *linkée* de manière dynamique au *run-time* :  elle est chargée en mémoire *une fois*, au moment de l’exécution.


## Créer la librairie partagée

Pour transformer `student` en code distribuable, on crée une librairie partagée (ou *shared library*) `libstudent.so` :


~~~bash
gcc -c student.c -o student.o
gcc -shared student.o -o libstudent.so
~~~

La librairie partagée `libstudent.so` est crée. Je distribue `student.h` et `student.so` aux utilisateurs. 

> Ma librairie partagée *est spécifique à une plateforme* (c'est du code compilé dans un certain format et cette librairie peut être elle aussi dépendante d'une autre librairie partagée présente sur le système !). Si elle est compilée pour GNU/Linux, elle ne pourra être exécutée par Windows ou Android par exemple.

## Utiliser la librairie dynamique dans son projet

En tant qu'utilisateur, je récupère une copie de ces deux fichiers (`student.h` et `libstudent.so`) pour les utiliser dans mon propre projet (ici `main.c`), mon code *client* :

### Compiler (compilation et assemblage)

1. Pour pouvoir utiliser la librairie `libstudent` dans mon projet, je dois include le header pour dire au compilateur que les appels de fonctions ou structure de données que j'utilise **sont définies quelque part** et que je respecte leur signature :

~~~c
#include "student.h"
~~~

Je compile mon projet, cela me crée un *object file* `main.o` :

~~~bash
gcc -c main.c
~~~

> On ne passe pas par l'étape d'assemblage explicitement ici, on passe tout de suite au fichier objet.

### Linker

Le binaire `myapp.o` n'est pas encore executable car il contient des *références* vers des libraires : `student` (`struct Student`, `createStudent`, etc. ) et `stdio.h` (`printf`). Inclure le header a permis de fournir des déclarations, donc lors de la phase de compilation, **le compilateur a seulement vérifié que les fonctions et structures existaient et avaient la bonne signature**. 

Le fichier objet contient encore ses références, elles doivent à présent être liées à leurs codes binaires respectif pour fabriquer l'executable. C'est l'étape **d'édition des liens** (*linking*). 

> Le système a des moyens (il est configuré pour) pour trouver tout seul l'emplacement de la librairie compilée de `stdio.h` (le binaire s'appelle `libc.so`). Mon executable sera linké de manière dynamique par le linker au binaire de `printf` (qu'il sait trouver). Je n'ai pas besoin de le faire explicitement ici.

Il faut donc ici seulement linker le fichier objet `main.o` avec la librairie dynamique `libmylib.so`


~~~bash
gcc -L$(pwd) main.o -lstudent -o myapp -Wl,-rpath,$(pwd)
~~~



## Changer d'implémentation par une autre à l'execution

Pour remplacer une implémentation par une autre, il suffit de disposer du header `student.h` pour connaître la signature des fonctions, proposer son implementation, et la linker dynamiquement a l'exec `myapp`.

Imaginons que l'on ait une deuxième implémentation de la library `student` (voir [`student-mod.c`](./student-mod.c)), et qu'on la compile en *shared library* sous le nom `libstudent2.so`. 

On peut changer d'implémentation *à l'exécution* en remplaçant la librairie liée. Il y a plusieurs méthodes possibles, il suffit en somme de dire que l'emplacement du code binaire à changer et de faire pointer le lien vers la nouveau binaire. Par exemple, en utilisant la variable d'environnement `LD_PRELOAD` (ou avec un lien symbolique, ou directement avec `LD_LIBRARY_PATH`) :

~~~bash
LD_PRELOAD=libstudent2.so ./myapp 
LD_PRELOAD=libstudent.so ./myapp
~~~ 

Voilà pourquoi on parle de *dynamic library*, c'est qu'elle peut être changée à l’exécution (au *runtime*) ! On peut ainsi déployer une mise à jour de `libstudent`, ou une version alternative *sans avoir à recompiler le code client* `main.c` !


## Créer un executable *standalone* : *dynamic library* vs *static library*

Une bibliothèque statique (*static library*), contrairement à une library dynamique ou partagée, est un ensemble de fonctions ou de données qui est **incorporé directement dans l'exécutable final lors de sa compilation**.

Cela augmente la taille de l'exécutable final, mais présente l'avantage que **le binaire distribué contient tout le code nécessaire pour s'exécuter et ne dépend pas de fichiers externes au moment de l'exécution**.

Compiler la lib `student` en statique :

~~~bash
gcc -c student.c -o student.o
#créer une lib statique (archive en .a)
ar rcs libstudent.a student.o
~~~

<!-- 
ar (archiver) L'option r indique à ar de remplacer ou d'ajouter les fichiers objet à la bibliothèque. L'option c crée la bibliothèque si elle n'existe pas. L'option s crée un index dans la bibliothèque, ce qui accélère le processus de liaison.
 -->

Compiler l'application en *standalone* (static library) et *comparer la taille des executables* `myapp` et `staticapp` :

 ~~~bash
gcc -o staticapp main.c -L.  -lstudent
gcc -static -o staticapp main.c -L.  -lstudent
#comparer la taille des deux executables
ls -lh | grep -e myapp -e staticapp
~~~

On voit que `staticapp` est environ *50 fois plus lourd* que `myapp`, car il contient tout le binaire de ses dépendances. L'avantage c'est que staticapp peut être distribué plus facilement car il est autonome et de dépend pas de la bonne installation et présence des librairies partagées sur la machine de l'utilisateur.

## Lien avec Flutter : Comment Flutter peut build du multi-natif à partir d'une même codebase ?

Une même application Dart/Flutter peut être compilée vers plusieurs plateformes. Pour cela, chaque application (code source Dart) *est embarquée dans un conteneur natif* (application) à l'OS. Le build d'une application Flutter se compose donc de trois parties :

- **Une partie agnostique de l'OS** (indépendantes).Il s'agit du code Dart que vous écrivez pour votre application. Ce code est compilé en une bibliothèque partagée (*shared library*) qui est indépendante de la plateforme sur laquelle l'application va s'exécuter. **Cette approche permet de réutiliser le même code Dart sur différentes plateformes sans modification**.
- **Une partie OS dépendante** fournie par Flutter. Flutter fournit une couche qui gère les interactions spécifiques à la plateforme, telles que l'interface utilisateur et le threading. **Cette partie inclut également le nécessaire pour intégrer votre application au système d'exploitation hôte comme l'affichage d'une fenêtre pour votre application**. Elle est également compilée en tant que bibliothèque partagée;
- **Un executable binaire**. **Il s'agit du code source de l'*embedder* (ou conteneur natif) spécifique à chaque plateforme**, qui **initialise l'environnement d'exécution de Flutter et charge votre application Dart**. Cet executable est le point d'entrée de votre application lors de son lancement. **Il est lié dynamiquement aux deux bibliothèques partagées mentionnées précédemment**, permettant ainsi à votre application de s'exécuter sur n'importe quelle plateforme supportée par Flutter tout en utilisant les capacités natives de celle-ci.

Cette architecture permet à Flutter d'offrir une grande flexibilité dans le développement d'applications "multi-natif", facilitant la création d'applications qui peuvent s'exécuter sur mobile, desktop et web avec une base de code unique et une expérience utilisateur cohérente sur toutes les plateformes.

> [En savoir plus](https://docs.flutter.dev/resources/architectural-overview#anatomy-of-an-app)


## Utiliser le Makefile

Un fichier `Makefile` permet de recompiler uniquement les fichiers dont les *dépendances ont été modifiées* (pas de recompilation inutile) :

~~~bash
#Compiler le projet
make
#Nettoyer
make clean
~~~

Ici on copie la librairie partagée dans le dossier `/usr/local/lib` car ce dossier est fait pour et se trouve naturellement sur le "PATH" des library partagées, appelé `LD_LIBRARY_PATH`.

Voir le fichier [Makefile](./Makefile) pour en savoir plus.


## Liens utiles

- [Dynamic Link Library](https://fr.wikipedia.org/wiki/Dynamic_Link_Library)
- [Shared Library](https://en.wikipedia.org/wiki/Shared_library)
- [Édition de liens et *linker*](https://fr.wikipedia.org/wiki/%C3%89dition_de_liens)