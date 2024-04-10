import 'package:main/city.dart';

/**
 * Ceci est un commentaire
 * sur plusieurs lignes
 */

// Ceci est un commentaire


///Modèle de ville avec région
class CityWithArea extends City{

  final String area;
  
  CityWithArea(super.name, super.county, this.area);

  @override
  String toString(){
    return "${super.toString()} dans la région $area";
  }

}