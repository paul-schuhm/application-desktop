# Flutter - Hello world !

Un simple programme *Hello world* pour prendre en main `Flutter 3.*` (Installation, core concepts, livrables)

## Lancer l'application sur le device *host*

A la racine du projet:

~~~
flutter run
~~~

## Exercice (Sujet du TP 1)

- Ajouter un bouton pour décrémenter l'état et changer le texte à `'Valeur du compteur : <valeur>'`. Le compteur ne peut pas avoir une valeur inférieure à 0
- Ajouter le fait que si le nombre de compteur est paire, l'arrière-plan de l'Appbar passe de la couleur `red`, impaire a la couleur `blue` 
- Ajouter un widget `Text` sur l'écran `"Pair"` si le nombre est paire, `"Impaire"` sinon
- Ajouter un widget `Text` sur l'écran qui répond au jeu du *FizzBuzz* : si le nombre est divisible par 3, un widget Text "Fizz" est ajouté, si le compteur est divisible par 5, un widget Text distinct "Buzz" est ajouté. Si divisible par 3 et par 5, les deux widgets sont affichés. Sinon, ils ne sont pas présents

> Ces petits exercices soulèvent tout un tas de questions : comment gérer l'espacement entre widget (layout), serait-il possible de rester cliqué sur les boutons pour faire défiler l'incrémentation, etc.