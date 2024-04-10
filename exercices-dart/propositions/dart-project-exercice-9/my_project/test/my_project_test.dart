import 'package:my_project/my_project.dart';
import 'package:test/test.dart';

void main() {
  test('find people born in winter', () {
    final Map<String, DateTime> people = {
      'John Doe': DateTime(1990, 1, 5),
      'Jane Smith': DateTime(1985, 3, 12),
      'Emily Davis': DateTime(1992, 3, 20),
      'David Wilson': DateTime(1982, 7, 3),
      'Jessica Anderson': DateTime(1998, 6, 8),
      'Christopher Martinez': DateTime(1987, 10, 17),
      'Olivia Thompson': DateTime(1991, 12, 21),
    };

    expect(listAllPeopleBornInWinter(people), ['John Doe', 'Jane Smith', 'Olivia Thompson']);
  });
}
