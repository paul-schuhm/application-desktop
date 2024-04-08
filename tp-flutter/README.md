# Mydigital School (Rennes) Développement Natif - Module 4 : TP Flutter

2023/2024

Version : 1

Des travaux pratiques pour maîtriser les concepts fondamentaux du framework Flutter :

- `StatelessWidget` vs `StatefulWidget`
- Les widgets built-in
- La mise en place d'un formulaire
- Phase de build et de réconciliation
- L'usage des `keys`
- La gestion d'état avec `setState`
- Le widget `InheritedWidget`
- La gestion d'état avec `InheritedWidget` et le paquet `provider`

## Table des matières

- [Mydigital School (Rennes) Développement Natif - Module 4 : TP Flutter](#mydigital-school-rennes-développement-natif---module-4--tp-flutter)
  - [Table des matières](#table-des-matières)
  - [TP 0 : Du bon usage des `keys`](#tp-0--du-bon-usage-des-keys)
    - [Partie 1 : widgets Stateless](#partie-1--widgets-stateless)
    - [Partie 2 : widgets Stateful](#partie-2--widgets-stateful)
  - [TP 1 : Extension du *Hello World*](#tp-1--extension-du-hello-world)
  - [TP 2 : Continuer le Google Codelabs](#tp-2--continuer-le-google-codelabs)
  - [TP 3 : Application de conversion d'unités](#tp-3--application-de-conversion-dunités)
    - [Prérequis](#prérequis)
    - [Objectifs](#objectifs)
    - [Spécifications](#spécifications)
    - [Tableau des facteurs de conversion entre unités de mesure](#tableau-des-facteurs-de-conversion-entre-unités-de-mesure)
    - [Conseils](#conseils)
    - [Widgets utiles](#widgets-utiles)
  - [TP 4 : Gestion des états avec `setState`](#tp-4--gestion-des-états-avec-setstate)
  - [TP 5 : Gestion des états avec `InheritedWidget`](#tp-5--gestion-des-états-avec-inheritedwidget)
  - [TP 6 : Gestion des états avec `provider`](#tp-6--gestion-des-états-avec-provider)
  - [Travail supplémentaire](#travail-supplémentaire)

<hr>


## TP 0 : Du bon usage des `keys`

Créer un nouveau projet Flutter. Dans ce projet, deux tuiles colorées seront affichées. Un bouton permettra d'intervertir les deux tuiles (swap).

### Partie 1 : widgets Stateless 

1. Créer un widget `StatelessTile` qui étend `StatelessWidget` et s'affiche comme un carré de 200 par 200 pixels d'une couleur aléatoire.
2. Créer un widget `PositionedTiles` qui étend `StatefulWidget` et maintient une liste `tiles` de 2 `StatelessTile`. Implémenter la méthode `initState` pour initialiser `tiles` avec deux widgets `StatelessTile`. `PositionedTiles` sera *build* avec cette implémentation :
~~~dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Row(children: tiles)),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.auto_fix_normal), onPressed: swapTiles),
    );
  }
~~~
3. Implémenter la méthode `swapTiles` qui intervertit les deux tiles. La première tile est placée en seconde position et inversement.
4. Tester votre code. 

### Partie 2 : widgets Stateful 

5. Créer un nouveau widget `StatefulTile` qui étend cette fois-ci la classe **`StatefulWidget`**. Cette fois-ci, la couleur sera un état et sera maintenue par la classe d'état compagnon. Dans la classe état, implémenter `initState` pour tirer une couleur aléatoire à maintenir.
6. Dans `PositionedTiles`, remplacez les tuiles `StatelessTile` par des tuiles `StatefulTile`. Tester à nouveau votre code. Qu'observez-vous ? Pourquoi ?
7. Corriger le problème à l'aide d'une key.

## TP 1 : Extension du *Hello World*

Étendre le projet *Hello World* (`flutter create hello-world`)

1. Ajouter un bouton pour décrémenter l'état et changer le texte à `'Valeur du compteur : <valeur>'`. Le compteur ne peut pas avoir une valeur inférieure à 0. 
2. Ajouter le fait que si le nombre de compteur est paire, l'arrière-plan de l'`AppBar` passe à la couleur `red`, impaire à la couleur `blue`.
3. Ajouter un widget `Text` sur l'écran `"Pair"` si le nombre est paire, `"Impaire"` sinon 
4. Ajouter un widget `Text` sur l'écran qui répond au jeu du *FizzBuzz* : si le nombre est divisible par 3, un widget `Text` "Fizz" est ajouté, si le compteur est divisible par 5, un widget `Text` distinct "Buzz" est ajouté. Si divisible par 3 et par 5, les deux widgets sont affichés. Sinon, ils ne sont pas affichés.

## TP 2 : Continuer le Google Codelabs

Suivre le [Google Codelabs : Créer votre première application Flutter](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=fr#0)

1. Rajouter un bouton pour supprimer un favori de la liste constituée.

## TP 3 : Application de conversion d'unités

### Prérequis

- Le SDK Flutter
- Android Studio
- Un émulateur de téléphone Android ou votre smartphone Android connecté à votre IDE

> Il faut développer vers la plateforme Android. Soit installer un nouveau device via Android Studio (le plus simple est de lancer un projet *Hello World* pour le configurer), soit directement sur votre téléphone (c'est mieux). Pour cela, il faut activer le mode développeur (Aller dans *A propos du téléphone*, cliquer 7 fois sur la version de build de l'OS. Puis dans la section *Developer options*, autoriser débugage via USB et installation d'application via USB. Brancher votre téléphone. Vérifier que votre appareil est bien connecté avec la commande `adb devices` (Android Debug Bridge)

### Objectifs

- `Statefull` vs `Stateless` widgets
- Gestion d'états (`State<E>`)
- Les évènements `onChanged` et `onSubmitted`
- Séparer l'UI de la logique métier

### Spécifications

1. Construire une application mobile Android de conversion. Cette application permet aux utilisateur·ices de convertir une valeur exprimée dans une unité de mesure en une autre (miles en kms, kg en pounds, etc.).

- Conversion de distance : m, km, feet, miles
- Conversion de masse : g, kg, livre (lbs), onces (16e de livre)

Lorsque la transformation n'est pas possible, indiquer-le à l'utilisateur avec un message `"This conversion cannot be performed"`.

### Tableau des facteurs de conversion entre unités de mesure

| De \ À        | Mètre (m) | Kilomètre (km) | Gramme (g) | Kilogramme (kg) | Pied (ft) | Mile (mi) | Livre (lb) | Once (oz) |
|--------------|-----------|-----------------|------------|-----------------|-----------|-----------|------------|-----------|
| Mètre (m)     | 1         | 0.001           | -       | -               | 3.28084   | 0.000621371 | -           | -           |
| Kilomètre (km)| 1000      | 1               | -       | -            | 3280.84   | 0.621371    | -           | -           |
| Gramme (g)    | -     | -            | 1          | 0.001           | -         | -           | 0.00220462 | 0.03527396 |
| Kilogramme (kg)| -        | -           | 1000       | 1               | -   | - | 2.20462    | 35.27396   |
| Pied (ft)     | 0.3048    | 0.0003048        | -          | -          | 1         | 0.000189394 | -           | -           |
| Mile (mi)     | 1609.34   | 1.60934         | -          | -         | 5280      | 1           | -           | -           |
| Livre (lb)    | -         | -               | 453592   | 0.453582        | -         | -           | 1           | 16          |
| Once (oz)     | -         | -               | 28.3495    | 0.0283495       | -         | -           | 0.0625      | 1           |

> Les `-` indique une conversion impossible (pas la même grandeur physique)

<img src="/assets/app-conversion.png" height="350"/>


2. À l'aide d'une méthode de gestion d'état, mettez à jour la liste des options de conversion réalisables et sensées en fonction de la grandeur de départ (au lieu de laisser l'utilisateur faire et lui afficher ensuite une erreur).

### Conseils

- Utiliser un widget `Stateful`
- Lire un user input
- Créer un dropdown
- Complete l'UI et Layout (`TextStyle`, `Spacer`, `Container` avec padding)
- Ajout de la logique métier (conversion)

### Widgets utiles 

- MaterialApp, Scaffold
- Column
- DropdownButton 
- Spacer

## TP 4 : Gestion des états avec `setState`

1. Créer 3 écrans : `Home`, `A` et `B`. La page Home doit avoir un widget `Text` qui montre la valeur du compteur (par défaut égale à `1`) et deux boutons. Chaque bouton permet de naviguer vers les écrans A et B respectivement. Chacune de ces pages ont aussi un widget `Text` qui affiche la valeur du compteur reçue par `Home` ainsi qu'un bouton pour incrémenter le compteur.

Les deux écrans `A` et `B` doivent permettre de mettre à jour le compteur, et la dernière mise à jour doit être répercutée sur tous les écrans. Par exemple, l'application démarre avec un compteur égal à 1. On navigue vers l'écran `A` et incrémente le compteur de 1. En naviguant sur l'écran `B` je dois avoir une valeur de 2. On incrémente le compteur de 3 sur l'écran `B`. Sur `Home` et `A`, je dois avoir une valeur de 5.

Pour cela, utiliser `setState` et la méthode de passage par push/pop ou par closure du [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html). Utiliser une application `MaterialApp`.

2. À présent, créer un widget `MyTextWidget` qui est un widget de texte personnalisé définissant une valeur de padding autour de lui et affichant un texte. Utiliser ce widget à la place du widget `Text` sur la page `B` avec un padding de `3` et affichant la valeur du compteur. Que devez-vous faire pour y parvenir ?

## TP 5 : Gestion des états avec `InheritedWidget`

1. Reproduire le TP 4 mais cette fois réaliser la gestion d'état via un [`InheritedWidget`](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html). Vous ne devez plus avoir à injecter l'état dans le constructeur des widgets. Dans un premier temps, ne pas réaliser pas la mise à jour de l'état (incrémenter le compteur) depuis les autres pages.

> Penser à wrap directement le widget `MaterialApp` dans l'`InheritedWidget` pour être sûr que les pages sur lesquelles vous naviguez puissent accéder à l'InheritedWidget.

2. Mettre en place le pattern avec les 3 classes pour pouvoir mettre à jour l'état centralisé du compteur de manière non locale, depuis la page A ou la page B.

## TP 6 : Gestion des états avec `provider`

Reproduire le TP 5 mais cette fois réaliser la gestion d'état avec le paquet [provider](https://pub.dev/packages/provider). Vous ne devriez plus à avoir à utiliser InheritedWidget directement ou devoir écrire le code boiler plate.

## Travail supplémentaire

Si vous avez fini les TP, demandez-moi d'autres sujets pour vous entraîner. 