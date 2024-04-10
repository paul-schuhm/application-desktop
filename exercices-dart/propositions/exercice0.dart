import 'dart:math';
import 'package:collection/collection.dart';
import 'package:collection_ext/all.dart';

///Proposition pour les questions 1 à 9
void question1to9() {
  int number = 42;

  //Dart convertit le résultat en double meme si number et 5 sont des entiers
  final division = number / 5;
  print(division);

  String text = 'Quelle est votre réponse ?';
  double decimalNumber = number.toDouble();
  String combinedText = '$text $number';

  print('Number: $number (Type: ${number.runtimeType})');
  print('String: $text (Type: ${text.runtimeType})');
  print('Decimal: $decimalNumber (Type: ${decimalNumber.runtimeType})');
  print('CombinedText: $combinedText (Type: ${combinedText.runtimeType})');

  print(
      "Le reste de la division de $number par 11 est : $number % 11 = ${number % 11}");
  print("La division entière de $number par 11 est ${number ~/ 11}");
  //Pour afficher un nombre avec un nombre de chiffres significatifs
  print((number / 11).toStringAsPrecision(3));
  //Pour afficher un nombre avec un nombre fixe de décimales (chiffres apres la virgule)
  print((number / 11).toStringAsFixed(3));
  print(combinedText.toUpperCase());
  print(combinedText.length);
  //Récupérer la réponse
  var questionEndsOn = combinedText.indexOf('?');
  print("La réponse est ${combinedText.substring(questionEndsOn + 1).trim()}");
}

///Proposition pour la question 10
void question10() {
  //On initialise un générateur de nombre aléatoires
  final randomGenerator = Random();
  //Ici on utilise IntRange du paquet collection_ext
  final randomNumbers =
      IntRange(0, 10).map((_) => randomGenerator.nextInt(50)).toList();
  final copyOfRandomNumbers = List<int>.from(randomNumbers);
  //Pour tester l'égalité des listes en valeur il faut : même taille, chaque élément est identique à chaque index
  //Ici on utilise la classe ListEquality<E> du paquet collection
  assert(ListEquality().equals(randomNumbers, copyOfRandomNumbers));

  //Calcul de la moyenne
  num mean = 0;
  for (final number in randomNumbers) {
    mean += number;
  }

  mean /= randomNumbers.length;

  print("La moyenne vaut ${mean.toStringAsPrecision(2)}");

  //Calcul de la médiane
  num mediane = 0;
  //On fait une copie pour ne pas modifier l'original lors du tri
  final copy = List.from(randomNumbers);
  //On trie du plus petit au plus grand
  copy.sort();
  if (copy.length.isEven) {
    //pour créer la valeur autour du "centre"
    int middle = copy.length ~/ 2;
    mediane = (copy[middle] + copy[middle - 1]) / 2;
    //Si il y a un nombre impaire de nombres, on prend la valeur du milieu de la série
  } else {
    //Si le nombre d'éléments est pair, il faut faire la moyenne des deux valeurs de part et d'autre
    //Remarque : s'il n'y a qu'un seul élément dans la chaîne, copy.length~/2 vaut 0 et le calcul fonctionne.
    int middle = copy.length ~/ 2;
    //La médiane est l'élément du milieu apres avoir trié du plus petit au plus grand
    mediane = copy[middle];
  }
  print('La médiane vaut $mediane');
}

void question11() {
  ///On peut utiliser trois guillements ''' pour avoir du texte non formatté (conserver les espaces, sauts à la ligne)
  ///
  String data = '''
randomemail1@example.com, emailaddress2@gmail.com, user3@hotmail.com, myemail4@yahoo.com, randomuser5@outlook.com, email6@gmail.com, user7@yahoo.com, myemailaddress8@hotmail.com, randomuser9@outlook.com, email10@yahoo.com
''';

  ///Le spread operator (...) est équivalent à transformer l'Iterable en List.
  ///En effet, map retourne un objet de type Iterable, non une liste. On le transforme donc en sous-type Liste
  ///(List implémente la classe abstraite Iterable.) pour continuer à travailler sur une liste par la suite
  List<String> emails = [...data.split(',').map((e) => e.trim())];
  //Equivalent à
  // List<String> emails = data.split(',').map((e) => e.trim()).toList();

  //Une map pour stocker nos statistiques. Chaque clef est un nom de domaine (hote), sa valeur est le compteur.
  Map<String, int> statistics = {};
  emails.forEach((element) {
    //Récupérer le nom de domaine
    int indexWhereHostStarts = element.indexOf('@') + 1;
    String host = element.substring(indexWhereHostStarts);
    //On initialise le compteur pour chaque hote si la clef n'existe pas encore
    if (!statistics.containsKey(host)) {
      statistics[host] = 0;
    }
    //On utilise le null assertion operator ! On assure ainsi au compilateur que statistics[host] n'est pas nul
    //https://dart.dev/codelabs/null-safety#the-null-assertion-operator-
    statistics[host] = statistics[host]! + 1;
  });
  statistics.forEach((key, value) {
    print("L'hôte $key apparaît $value fois sur ${emails.length}");
  });
}

///Proposition pour la question 12
void question12() {
  String string =
      'Cat, Sunshine, Bicycle, Fish, Harmony, Dart, Pillow, Atmosphere, Whisper, Chocolate, Adventure';

  //On transforme cela en liste pour faire le tri
  List<String> words = [...string.split(',').map((e) => e.trim())];

  //Sort prend en argument une fonction de type 'Comparator' (c'est un typedef, un alias de type pour une fonction. Cela permet d'imposer une signature pour la fonction de comparaison. Toute fonction 'Comparator' doit respecter la signature de cette fonction générique : int Comparator(T a,T b ))
  //Voir ici : https://api.dart.dev/stable/3.1.3/dart-core/Comparator.html

  //On implémente un comparateur nous meme (ici de manière anonyme), l'algo de tri de la méthode sort s'en servira
  words.sort((word1, word2) {
    //Ici on veut trier du plus petit au plus grand
    final l1 = word1.length;
    final l2 = word2.length;
    //si l1 doit etre placé avant l2, on retourne une valeur négative
    if (l1 < l2)
      return -1;
    //si l1 et l2 sont égaux, on retourne 0 (l'algorithme décide)
    else if (l1 == l2)
      return 0;
    //si l1 doit etre placé après l2, on retourne une valeur positive
    else
      return 1;
  });

  //Solution plus lisible, en se servant de dart:core
  words.sort((word1, word2) => word1.length.compareTo(word2.length));

  //Créer son propre comparateur :

  //Il faut respecter la signature d'une fonction de comparaison : int Function(T a, T b)
  // int ComparatorBySize(String a, String b) {
  //   return a.length.compareTo(b.length);
  // }

  // int ComparatorAlphabetical(String a, String b) {
  //   return a.compareTo(b);
  // }

  //Ou utiliser le typedef Comparator<T> directement

  ///Comparateur de taille de chaines de caractère
  Comparator<String> comparatorByLength = (String a, String b) {
    return a.length.compareTo(b.length);
  };

  ///Comparateur alphabétique
  Comparator<String> comparatorAlphabetical = (String a, String b) {
    return a.compareTo(b);
  };

  ///Comparateur par taille de chaine de caractere. Si deux chaines ont la meme taille,
  ///les compare alphabétiquement
  Comparator<String> comparatorByLengthAndAlphabetical = (String a, String b) {
    //Si les deux mots ont la meme taille, on fait le tri alphabétique
    if (a.length == b.length) {
      return comparatorAlphabetical(a, b);
      //Sinon on fait seulement le trie par taille
    } else {
      return comparatorByLength(a, b);
    }
  };

  words.sort(comparatorByLengthAndAlphabetical);
  print(words);
}

void main() {
  question1to9();
  question10();
  question11();
  question12();
}
