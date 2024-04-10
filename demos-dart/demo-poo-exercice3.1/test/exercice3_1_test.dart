import 'package:test/test.dart';
import 'package:main/city_with_area.dart';
import 'package:main/city.dart';

void main() {
  test('La ville avec le nom le plus long manipulée par mon programme est bien déterminée', () {
    final nantes = City('Nantes', 'Loire-Atlantique');
    final rennes = CityWithArea('Saint-Brevin-Les-Pins', 'Loire-Atlantique', 'Pays de la Loire');

    expect(City.cityWithLongestName, 'La ville ayant le nom le plus long manipulée par le programme est Saint-Brevin-Les-Pins');
  });
}
