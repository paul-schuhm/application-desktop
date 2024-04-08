# Première application Flutter

- [Première application Flutter](#première-application-flutter)
  - [Description](#description)
  - [Installation](#installation)
  - [Lancer l'application (en debug mode)](#lancer-lapplication-en-debug-mode)
  - [Erreurs rencontrées](#erreurs-rencontrées)
    - [Etape 3 : Dépendances non résolues automatiquement](#etape-3--dépendances-non-résolues-automatiquement)
  - [Debrief collectif](#debrief-collectif)
  - [Liste des concepts et expressions nouvelles ou inconnues rencontrées](#liste-des-concepts-et-expressions-nouvelles-ou-inconnues-rencontrées)
    - [Général](#général)
    - [Layout](#layout)
    - [Gestion d'état et pattern Observer en Flutter](#gestion-détat-et-pattern-observer-en-flutter)
    - [Syntaxe](#syntaxe)
  - [Exercices](#exercices)
  - [Références](#références)


## Description

Première application Flutter développée en suivant le [Codelabs : Créer votre première application Flutter](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=fr#0)

Les objectifs d'apprentissage sont les suivants :

- Fonctionnement de base de Flutter
- Créer des mises en page sous Flutter
- Associer les interactions utilisateur (appuis de bouton, par exemple) aux comportements de l'application
- Assurer l'organisation du code Flutter
- Rendre l'application responsive (aux différents écrans)
- Proposer une interface homogène
- Découvrir Dart et noter ce qui n'est pas familier

## Installation

~~~bash
flutter create app --project-name=first-app
~~~

## Lancer l'application (en debug mode)

A la racine du projet

~~~bash
cd first-app
flutter run
~~~

## Erreurs rencontrées

Liste des erreurs rencontrés en réalisant le CodeLabs (non à jour avec les dernières versions de Flutter/Dart)

### Etape 3 : Dépendances non résolues automatiquement

Dans le fichier `pubspec.yaml`, renseigner les dépendances du projet

~~~yaml
dependencies:
  english_words: ^4.0.0
  provider: ^6.0.5
~~~

Pour installer les dépendances renseignées

~~~bash
flutter pub get
~~~

Pour lister toutes les dépendances du projet

~~~bash
flutter pub deps
~~~

Si vous êtes dans VS Code, enregistrer les modifications. Le plugin Flutter va automatiquement installer les dépendances.

## Debrief collectif

[Voir le code commenté](./app/lib/main.dart).

## Liste des concepts et expressions nouvelles ou inconnues rencontrées

### Général

- `MyApp` : *Widget Root*. Initialise l'état de l'application et configure l'ensemble de l'application (nom, theme visuel, home)
- `MyAppState` : définit l'état de l'application
- Certains états sont spécifiques à un widget et *doivent donc rester avec lui*.

### Layout

- Utiliser le [Flutter widget Inspector](https://docs.flutter.dev/tools/devtools/inspector). Utile pour debug le layout
- Observer le comportement du Widget `Column` (il s'adapte à la taille du plus grand widget enfant)

### Gestion d'état et pattern Observer en Flutter

<!-- ![w:300px](../../assets/dp-observer-flutter-provided.svg) -->

<img src="../../assets/dp-observer-flutter-provided.svg" alt="Schéma UML du pattern Observer, implémentation en Flutter" width="90%">

- classe `ChangeNotifier` : une classe qui peut notifier ses listeners de ses propres modifications d'état. Fournie par le paquet Dart `provider`. Voir partie du cours gestion d'état
- classe `ChangeNotifierProvider` : Permet une gestion centralisée de l'état de l'application (Pattern Observer). Fournie par le paquet Dart `provider`. C'est un Widget spécial. Voir la partie du cours sur la gestion d'état
- context : objet qui porte toutes les informations sur l'élément associé au widget (position, taille, parent, enfant), à l'instance en live du widget
- `var appState = context.watch<MyAppState>` : Récupere l'instance de MyAppState associée au ChangeNotifier le plus proche. Voir partie du cours sur gestion d'état.

### Syntaxe

- `() {print('Button pressed');}` : syntaxe d'une fonction anonyme
- `const MyApp({super.key});` : déclaration du constructeur avec argument nommé. Ici on passe la valeur de l'argument nommé `key` de type `Key` à la classe parente de type `StatelessWidget` (d'où le `super`)

~~~dart
(new) Text Text(
  String data, {
  Key? key,
  TextStyle? style,
  StrutStyle? strutStyle,
  TextAlign? textAlign,
  TextDirection? textDirection,
  Locale? locale,
  bool? softWrap,
  TextOverflow? overflow,
  double? textScaleFactor,
  int? maxLines,
  String? semanticsLabel,
  TextWidthBasis? textWidthBasis,
  TextHeightBehavior? textHeightBehavior,
  Color? selectionColor,
})
~~~

Tout ce qui entre accolades (`{}`) sont des arguments nommés optionnels. Ici donc, seul le premier argument `data` est obligatoire


## Exercices

- Rajouter un bouton pour supprimer un favori

## Références

- [Codelabs : Créer votre première application Flutter](https://codelabs.developers.google.com/codelabs/flutter-codelab-first?hl=fr#0)
- [Observer Pattern](https://refactoring.guru/fr/design-patterns/observer), de la documentation sur le design pattern Observer
- [Accessibility](https://docs.flutter.dev/ui/accessibility-and-localization/accessibility?tab=voiceover#screen-readers), rappels sur l'accessibilité des applications appliqué à Flutter
- [Documentation du Flutter widget Inspector](https://docs.flutter.dev/tools/devtools/inspector)