import '../lib/my_project.dart';

void main(List<String> arguments) {
  final Map<String, DateTime> people = {
    'John Doe': DateTime(1990, 1, 5),
    'Jane Smith': DateTime(1985, 3, 12),
    'Emily Davis': DateTime(1992, 3, 20),
    'David Wilson': DateTime(1982, 7, 3),
    'Jessica Anderson': DateTime(1998, 6, 8),
    'Christopher Martinez': DateTime(1987, 10, 17),
    'Olivia Thompson': DateTime(1991, 12, 21),
  };

  print(listAllPeopleBornInWinter(people));

  ///Test les réglages de l'analyse statique
  final foo = [1, 2, 3];
  ///Si bien configuré (exercice 9), l'inférence doit échouer ici : strict-inference: true
  final lines = {};
  foo.add(5);
}
