
///Retourne le nombre le plus grand, null si [numbers] est vide
///
///```dart
///assert(maxNumber1([])==null);
///```
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

///Retourne la liste des personnes nées en hiver, selon la définition française
///
///L'hiver est défini par deux dates :
///
///- `endOfWinter` : 12 décembre
///- `startOfWinter` le 20 avril (inclus)
List<String> listAllPeopleBornInWinter(Map<String, DateTime> map) {
  ///On transforme map en Iterable pour utiliser la méthode where
  final bornInWinter = map.entries.where((entry) {
    final startOfWinter = DateTime(entry.value.year, 12, 21);
    final endOfWinter = DateTime(entry.value.year, 3, 20);
    return entry.value.isAfter(startOfWinter) ||
        entry.value.isBefore(endOfWinter) ||
        entry.value.isAtSameMomentAs(startOfWinter);
  });

  return bornInWinter.map<String>((entry) => entry.key).toList();
}

///Retourne la liste des personnes nées en hiver
///
///Autre solution. La première solution [listAllPeopleBornInWinter] est plus lisible et à préférer
@Deprecated("Use listAllPeopleBornInWinter instead")
List<String> listAllPeopleBornInWinter2(Map<String, DateTime> map) {
  const dayEndOfWinter = 20;
  const monthEndOfWinter = 3;
  const monthStartOfWinter = 12;
  const dayStartOfWinter = 21;

  final bornInWinter = map.entries.where((entry) {
    final month = entry.value.month;
    final day = entry.value.day;
    return month <= monthEndOfWinter && day < dayEndOfWinter ||
        month == monthStartOfWinter && day >= dayStartOfWinter;
  });

  return bornInWinter.map<String>((entry) => entry.key).toList();
}

///Retourne un jeu de fizzbuzz de longueur [n] (de manière récursive)
String fizzBuzzRecursive(int n) {
  // for(Range.)
  if (n == 1) return 1.toString();

//On construit à l'envers
  if (n % 3 == 0 && n % 5 == 0) return "${fizzBuzzRecursive(n - 1)} Fizz Buzz";
  if (n % 3 == 0) return "${fizzBuzzRecursive(n - 1)} Fizz";
  if (n % 5 == 0) return "${fizzBuzzRecursive(n - 1)} + Buzz";

  return "${fizzBuzzRecursive(n - 1)} {n.toString()}";
}