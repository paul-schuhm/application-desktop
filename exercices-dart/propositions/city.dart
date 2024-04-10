class City {
  ///On ne veut pas de setter implicite
  final String name;
  final String county;
  static String _longestCityName='';

  ///Constructeur avec le pattern initializing formal parameters
  ///Voir : https://dart.dev/language/constructors#initializing-formal-parameters
  City(this.name, this.county){
    if(name.length > City._longestCityName.length){
      City._longestCityName = name;
    }
  }

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is City && other.county == county && other.name == name;
  }

  ///Sinon on override l'opérateur d'égalité, il est conseillé d'override le hashage de l'objet aussi
  ///Voir https://api.dart.dev/stable/3.1.2/dart-core/Object/hashCode.html
  @override
  int get hashCode => Object.hash(name, county);

  @override
  String toString() {
    return '$name se situe dans le département $county';
  }

  static String? get cityWithLongestName => "La ville avec le nom le plus long est ${City._longestCityName}";
}

class CityWithArea extends City {

  final String area;

  CityWithArea(String name, String county, this.area): super(name, county);

  @override
  String toString() {
    return '${super.toString()} de la région $area';
  }
}
