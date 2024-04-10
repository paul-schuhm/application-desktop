import 'dart:math';

import 'package:collection/collection.dart';
import 'package:collection_ext/all.dart';
//Internationalisation
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//Timezone
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

//1

///Retourne le nombre le plus grand, null [numbers] est vide
num? maxNumber1({required List<num> numbers}) {
  if (numbers.isEmpty) return null;
  var max = numbers[0];
  for (final number in numbers) {
    if (number > max) {
      max = number;
    }
  }
  return max;
}

///Retourne le nombre le plus grand, null si la liste est vide (en utilisant reduce)
num? maxNumber2({required List<num> numbers}) {
  if (numbers.isEmpty) return null;
  return numbers.reduce((value, element) => value > element ? value : element);
}

//Retourne le nombre le plus grand, null si la liste est vide (en utilisant sort)
num? maxNumber3({required List<num> numbers}) {
  if (numbers.isEmpty) return null;
  //On fait une copie pour ne pas modifier l'originale
  var tmp = List.from(numbers);
  tmp.sort();
  return tmp.last;
}

//2

///Effectue la somme de manière récursive (side effects: modifie la liste)
num sumRecursive(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  return numbers.removeAt(0) + sumRecursive(numbers);
}

///Effectue la somme de manière récursive sans effets de bord
///en faisant une copie de la liste à chaque appel
num sumRecursiveWithoutSideEffectsCopy(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  var copy = List<num>.from(numbers);
  return copy.removeAt(0) + sumRecursive(copy);
}

///Effectue la somme de manière récursive sans effets de bord
///en faisant avancer le pointeur [index] à chaque appel
num sumRecursiveWithoutSideEffectsPointer(List<num> numbers, {int index = 0}) {
  ///Condition d'arrête : index sort de la liste
  if (index == numbers.length) {
    return 0;
  }
  return numbers[index] +
      sumRecursiveWithoutSideEffectsPointer(numbers, index: index + 1);
}

//3

///Retourne la somme des nombres compris entre a et b
///Lève une exception si a >= b
int sumInRange(List<int> list, int a, int b) {
  if (a >= b) throw Exception("a doit être inférieur à b");
  if (list.isEmpty) return 0;

  //On utilise la méthode where (filter)
  var range = list.where((number) => number >= a && number <= b);

  //fold est comme reduce, mais on peut initialiser l'accumulateur
  return range.fold<int>(0, (prev, current) => prev + current);
  //Remarque : on peut aussi utiliser la variable sum du package 'collection' à installer et importer
  //return range.sum; ou utiliser notre fonction somme définie précédemment
}

//4

///Retourne le résultat de l'opération f sur chacun des nombres compris entre a et b
///Lève une exception si a >= b
int? applyOnRange(List<int> list, int a, int b, int Function(int, int) f) {
  if (a >= b) throw Exception("a doit être inférieur à b");
  if (list.isEmpty) return 0;

  //On utilise la méthode where (filter)
  var range = list.where((number) => number >= a && number <= b);
  return range.reduce((prev, current) => f(prev, current));
}



//5

///Renvoie vrai si [text] est un palindrome, faux sinon
bool isPalindrome(String text) =>
    text.toLowerCase().replaceAll(' ', '') ==
    text.toLowerCase().replaceAll(' ', '').split('').reversed.join();

//6

///Retourne le nombre d'essais pour retrouver aléatoirement [target]
int howManyTriesToRandomlyFind(int target) {
  final randomGenerator = Random();
  var numberOfTries = 0;
  while (randomGenerator.nextInt(100) != target) {
    numberOfTries++;
  }
  return numberOfTries;
}

//7

///Retourne le nombre de secondes passées depuis [date]
int calculateSecondsSpentSince(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);
  return difference.inSeconds;
}

//8

///Retourne le jour de la semaine de [date] en français
String whichDayOfTheWeekIs(DateTime date) {
  initializeDateFormatting('fr');
  final formater = DateFormat('EEEE', 'fr');
  return formater.format(date);
}

//9

///Affiche les heures courantes à Paris, Londres et Sydney
void printCurrentLocalTimes() {
  //On initialise la bdd des timezone
  tz.initializeTimeZones();
  //On cree la date courante dans la timeZone courante (UTC+1 ou UTC+2 en France métropolitaine)
  final now = DateTime.now();
  //On cree un format que l'on va réutiliser
  final formater = DateFormat('Hm');
  //On initialise les différentes locations
  final paris = tz.getLocation('Europe/Paris');
  final london = tz.getLocation('Europe/London');
  final sydney = tz.getLocation('Australia/Sydney');
  //On imprime la date dans différentes timeZone au format désiré
  //Si on execute ce code ailleurs qu'en France métropolitaine, l'heure de Paris sera toujours correcte
  print("À Paris, il est ${formater.format(tz.TZDateTime.from(now, paris))}");
  print(
      "À Londres, il est ${formater.format(tz.TZDateTime.from(now, london))}");
  print("À Sydney, il est ${formater.format(tz.TZDateTime.from(now, sydney))}");
}

//10

///Retourne un jeu de Fizzbuzz de taille [n] (de manière itérative)
String fizzBuzzIterative(int n) {
  if (n <= 0) throw Exception("Le jeu doit commencer au moins à 1 !");

  String game = '';

//IntRange est fourni par le paquet collection_ext (une extension du paquet collection)
//Pour l'installer : dart pub add collection_ext
  for (final number in IntRange(1, n, step: 1)) {
    String answer = '';
    if (number % 3 == 0) answer += 'Fizz ';
    if (number % 5 == 0) answer += 'Buzz ';
    if (answer.isEmpty) answer += number.toString() + ' ';

    game += answer;
  }

  return game.trim();
}

///Retourne un jeu de fizzbuzz de taille [n] (de manière récursive)
String fizzBuzzRecursive(int n) {
  // for(Range.)
  if (n == 1) return 1.toString();

//On construit à l'envers
  if (n % 3 == 0 && n % 5 == 0) return fizzBuzzRecursive(n - 1) + ' Fizz Buzz';
  if (n % 3 == 0) return fizzBuzzRecursive(n - 1) + ' Fizz';
  if (n % 5 == 0) return fizzBuzzRecursive(n - 1) + ' Buzz';

  return fizzBuzzRecursive(n - 1) + ' ${n.toString()}';
}

//11

///Retourne la liste des personnes parmi [people] nées en hiver (autre solution. La première est plus lisible)
@Deprecated("Use listAllPeopleBornInWinter instead")
List<String> listAllPeopleBornInWinterV1(Map<String, DateTime> people) {
  const dayEndOfWinter = 20;
  const monthEndOfWinter = 3;
  const monthStartOfWinter = 12;
  const dayStartOfWinter = 21;

  final bornInWinter = people.entries.where((entry) {
    final month = entry.value.month;
    final day = entry.value.day;
    return month <= monthEndOfWinter && day < dayEndOfWinter ||
        month == monthStartOfWinter && day >= dayStartOfWinter;
  });

  return bornInWinter.map<String>((entry) => entry.key).toList();
}

///Retourne la liste des personnes parmi [people] nées en hiver
List<String> listAllPeopleBornInWinter(Map<String, DateTime> people) {
  ///On transforme map en Iterable pour utiliser la méthode where
  final bornInWinter = people.entries.where((someone) {
    final birthDate = someone.value;
    final startOfWinter = DateTime(someone.value.year, 12, 21);
    final endOfWinter = DateTime(someone.value.year, 3, 20);
    return birthDate.isAfter(startOfWinter) ||
        birthDate.isBefore(endOfWinter) ||
        birthDate.isAtSameMomentAs(startOfWinter);
  });

  return bornInWinter.map<String>((someone) => someone.key).toList();
}

/// Que se passe-t-il si on ajoute cette nouvelle entrée dans la map : `David Wilson - 1973 01 24` ? Pourquoi ?
/// Un entrée avec la clef 'David Wilson' existe déjà dans la Map, donc on écrase l'ancienne valeur par la nouvelle. Une Map ne maintient que des clefs uniques associée chacune à une seule valeur.

///Tests

void main() {
  //1
  List<num> numbers = [-1, -52.3, 48, 38, 1000, 0, -1, 376, 999];
  List<num> copyNumbers = List.from(numbers);
  print(maxNumber1(numbers: numbers));
  //S'assurer que les différentes implémentations donnent la même réponse (qui peut être fausse ! Au moins, on s'assure qu'elles sont toutes fausses !)
  assert(maxNumber1(numbers: numbers) == maxNumber2(numbers: numbers) &&
      maxNumber1(numbers: numbers) == maxNumber3(numbers: numbers));

  //2
  List<num> simpleList = [1, 2, 3, -6];
  List<num> copySimpleList = List.from(simpleList);

  //3
  print(sumInRange(simpleList.cast<int>(), 1, 2));

  //4
  //Multiplication des éléments
  print(applyOnRange(
      [1, 2, 3, 4], 1, 3, (previous, current) => previous * current));

  //Somme au carré des éléments
  print(applyOnRange(
      [1, 2, 3, 4], 1, 3, (previous, current) => previous + current * current));

  //On vérifie que toutes nos appels de fonctions sont sans effets de bord et n'ont pas
  //modifié les listes originales
  try {
    assert(const ListEquality().equals(numbers, copyNumbers),
        "Attention, une fonction a modifié la liste simpleList !");
    assert(const ListEquality().equals(simpleList, copySimpleList),
        "Attention, une fonction a modifié la liste numbers !");
  } on AssertionError catch (e) {
    print("${e.message}");
  }

  //5
  print(isPalindrome("Engage le jeu que je le gagne"));

  //6
  // print(howManyTriesToRandomlyFind(50));

  //7
  print(calculateSecondsSpentSince(DateTime(1990, 6, 21)));

  //8
  print(whichDayOfTheWeekIs(DateTime.now()));
  print(whichDayOfTheWeekIs(DateTime(1989, 11, 9)));

  //9
  printCurrentLocalTimes();

  //10
  print(fizzBuzzIterative(25));
  print(fizzBuzzRecursive(25));

  ///Un petit test rapide pour voir si nos implémentations sont bonnes (ou toutes les deux fausses)
  ///Est-ce que ce test est suffisant pour avoir confiance en nos implémentations ?
  ///Non, car les deux implémentations fizzBuzzIterative et fizzBuzzRecursive pourraient être fausses et renvoyer un même faux résultat identique. Il faudrait comparer une implémentation à une valeur Cible attendue, et si fizzBuzzIterative vaut Cible et fizzBuzzRecursive vaut fizzBuzzIterative alors fizzBuzzRecursive vaut Cible, et là on sera (davantage) convaincu que nos implémentations sont bonnes.
  assert(fizzBuzzIterative(25) == fizzBuzzRecursive(25));

  //11

  Map<String, DateTime> persons = {
    'John Doe': DateTime(1990, 1, 5),
    'Jane Smith': DateTime(1985, 3, 12),
    'Emily Davis': DateTime(1992, 3, 20),
    'David Wilson': DateTime(1982, 7, 3),
    'Jessica Anderson': DateTime(1998, 6, 8),
    'Christopher Martinez': DateTime(1987, 10, 17),
    'Olivia Thompson': DateTime(1991, 12, 21),
  };

  print(listAllPeopleBornInWinter(persons));

  //12
  
  ///Avec annotation de type
  String Function(num, num) chooseOperation(int a, int b) {
    if (a < b) {
      return (num a, num b) => (a * b).toString();
    } else
      return (num a, num b) => (a ~/ b).toString();
  }

  ///Sans annotation de type(inférence)
  Function chooseOperationWithoutAnnotation(int a, int b) {
    if (a < b) {
      return (num a, num b) => a * b;
    } else
      return (num a, num b) => a ~/ b;
  }

  final operation = chooseOperation(2, 1);
  print(operation(3, 2));

  //13

  /// Retourne la dérivée d'une fonction [f]
  num Function(num x) deriv(num Function(num x) f) {
    const dx = 0.000001;
    ///Cette fonction est une closure: elle capture la valeur de dx et de f
    ///lors de sa déclaration
    return (num x) {
      return (f(x + dx) - f(x)) / dx;
    };
  }

  ///La fonction cube
  final f = (num x) {
    return x * x * x;
  };

  final df = deriv(f);
  print(f(2));
  print(df(2));
}
