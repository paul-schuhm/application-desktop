class City {
  ///Le nom de la ville
  final String name;

  ///Le département de la ville
  final String county;

  City(this.name, this.county) {
    if (name.length > _cityWithLongestName.length) {
      _cityWithLongestName = name;
    }
  }

  ///Maintient le nom de ville le plus long manipulé durant l'execution du programme
  static String _cityWithLongestName = '';

  ///Getter
  static String get cityWithLongestName =>
      "La ville ayant le nom le plus long manipulée par le programme est $_cityWithLongestName";

  @override
  String toString() {
    return "$name est dans le département $county";
  }

  ///Retourne la distance en km à la ville [city]
  double distanceTo(City city) {
   throw UnimplementedError();
  }
}
