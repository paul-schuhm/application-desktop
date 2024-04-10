import 'city.dart';

void main() {
  final cities = [
    CityWithArea('Rennes', 'Ille-et-vilaine', 'Bretagne'),
    CityWithArea('Saint-Brevin-les-Pins', 'Loire-Atlantique', 'Pays de la Loire'),
    CityWithArea('Plescop', 'Morbihan', 'Bretagne'),
  ];
  print(City.cityWithLongestName);
}
