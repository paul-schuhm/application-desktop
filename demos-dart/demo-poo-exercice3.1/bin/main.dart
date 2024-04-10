import 'package:main/city.dart';
import 'package:main/city_with_area.dart';

void main(List<String> arguments) {
  final nantes = City('Nantes', 'Loire-Atlantique');
  final rennes = CityWithArea('Saint-Brevin-Les-Pins', 'Loire-Atlantique', 'Pays de la Loire');
  print(rennes);
  print(City.cityWithLongestName);
}
