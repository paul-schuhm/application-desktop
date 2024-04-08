import 'package:flutter/foundation.dart';
import 'package:english_words/english_words.dart';

// Widget qui définit l'état centralisé de l'application

// ChangeNotifier : Widget qui peut notifier les autres Widgets de ses changements d'état
class MyAppState extends ChangeNotifier {
  //Le double mot courant
  var currentWordPair = WordPair.random();
  // La listes des favoris
  var favorites = <WordPair>[];

//Comportements:

  ///Ajoute ou retire un favori de la liste
  void toggleFavorite() {
    if (favorites.contains(currentWordPair)) {
      favorites.remove(currentWordPair);
    } else {
      favorites.add(currentWordPair);
    }
    notifyListeners();
  }

  ///Générer le prochain favori de la liste
  void getNext() {
    currentWordPair = WordPair.random(maxSyllables: 4);
    notifyListeners();
  }

  ///Retire un favori de la liste
  void removeFavorite(WordPair favorite) {
    if (favorites.contains(favorite)) {
      favorites.remove(favorite);
    }
    notifyListeners();
  }
}
