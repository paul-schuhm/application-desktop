import 'dart:math';
import 'dart:io';

import 'package:csv/csv.dart';

///Note: Ce code a été écrit en suivant les consignes. Refactor ce code maintenant qu'il y a les deux modes (via import fichier csv ou via l'entrée standard). Laissé en exercice.
///Améliorations :
///- refactor les deux modes pour mettre en commun ce qu'il y a a mettre via des fonctions appropriées
///- paramètrer le compilateur pour identifier et retirer toutes les inférences ratées (dynamic)
///- gérer le cas de mauvaise input utilisateur (nombre négatif)
///- Etc.

//On définit un alias de type Cylinder qui est de type Record
//avec deux champs obligatoires et nommés de type num
typedef Cylinder = ({num radius, num height});

//1

///Retourne le volume d'un cylindre de rayon [radius] et de hauteur [height]
double computeCylinderVolume({required num radius, required num height}) {
  //Exception à gerer : si user rentre une mauvaise donnée ou erreur dans le CSV
  if (radius <= 0 || height <= 0)
    throw Exception("Les dimensions du cylindre doivent être positives !");
  return pi * radius * radius * height;
}

//2 Ici on plusieurs sous-problème: déterminer si le cylindre est accepté ou non, informer l'utilisateur, filtrer les cylindres (composition des deux premières fonctions)

///Retourne vrai si le cylindre est utilisable pour l'experience, faux sinon
bool isCylinderAcceptedForTheExperiment(
    {required num radius, required num height}) {
  const minVolume = 450;
  const minRadius = 7;
  final volume = computeCylinderVolume(radius: radius, height: height);

  return volume > minVolume && radius > minRadius;
}

///Autre solution
///Retourne vrai si le cylindre est utilisable pour l'experience, faux sinon
bool isCylinderAcceptedForTheExperiment2(
    {required num radius, required num height}) {
  const minRadius = 7;
  const minVolume = 450;
  const minHeight = minVolume / (pi * minRadius * minRadius);

  return height > minHeight && radius > minRadius;
}

//On découple les deux, si jamais on souhaite écrire la réponse dans un autre format (HMTL, Markdown, XML, JSON, etc.)
///Retourne un message approprié si le cylindre est accepté ou non
String informUser(bool isCylinderAccepted) {
  switch (isCylinderAccepted) {
    case true:
      return 'Cylindre accepté';
    case false:
      return 'Cylindre rejeté';
  }
}

///Retourne un message à l'utilisateur pour indiquer si le cylindre est adapté pour l'experience ou non
String reportIfCylinderIsAcceptedForExperiment(
    {required num radius, required num height}) {
  final answer =
      isCylinderAcceptedForTheExperiment(radius: radius, height: height);

  //Juste en test
  assert(answer ==
      isCylinderAcceptedForTheExperiment2(radius: radius, height: height));
  return informUser(answer);
}

///Décompose les données reçues via l'entrée standard et les transforme en dimensions du cylindre.
///Les données attendues sont le rayon et la hauteur du cylindre, séparés par un espace.
///Lève une Exception si les données ne sont pas valides
Cylinder readStdinIntoCylinder(String? input) {
  const message =
      "Données fournies incorrectes.\nMerci de renseigner le rayon et la hauteur du cylindre, séparés par un espace";

  if (input == null) {
    throw new Exception(message);
  }

  //Une entrée valide contient seulement 2 arguments séparés par des espaces

  final argumentsList = input.split(' ');

  if (argumentsList.length != 2) {
    throw new Exception(message);
  }

  final radius = argumentsList[0];
  final height = argumentsList[1];

  late num radiusNumber;
  late num heightNumber;

  try {
    radiusNumber = num.parse(radius);
    heightNumber = num.parse(height);
  } on FormatException {
    throw new Exception(message);
  }

  return (radius: radiusNumber, height: heightNumber);
}

void main(List<String> arguments) {
  String? input;

  //Mode fichier
  if (!arguments.isEmpty && arguments.length == 1) {
    stdout.writeln(
        'Chargement d\'un fichier CSV contenant les données au format radius, height');

    final fileName = arguments[0];

    if (!fileName.endsWith('.csv')) {
      stdout.writeln('Merci de fournir un fichier avec l\'extension .csv');
      return;
    }

    late final csvList;

    //Lecture du fichier et conversion en chaine de caractre en utilisant le format CSV
    try {
      File file = File(fileName);
      //On lit de manière synchrone le contenu du fichier
      final content = file.readAsStringSync();
      //Convertit le csv en liste (lignes) de liste (colonnes)
      csvList = CsvToListConverter(
              eol: '\n', fieldDelimiter: ',', allowInvalid: false)
          .convert(content);
    } catch (e) {
      stdout.writeln('Merci de fournir un fichier csv valide');
      return;
    }

    //Retire les lignes de commentaires, qui commence par un #
    final csvListData = csvList.where((line) {
      return !line[0].toString().startsWith('#');
    });

    final List<Cylinder> cylinders = [
      ...csvListData.map((line) {
        return (radius: line[0], height: line[1]);
      })
    ];

    var inspectedCylinders = cylinders.map((cylinder) {
      return (
        radius: cylinder.radius,
        height: cylinder.height,
        volume: computeCylinderVolume(
            radius: cylinder.radius, height: cylinder.height),
        report: reportIfCylinderIsAcceptedForExperiment(
            radius: cylinder.radius, height: cylinder.height)
      );
    }).toList();

    //Affichage du résultat:
    inspectedCylinders.forEach((cylinder) {
      print(
          '${cylinder.report.padRight(20)} : (Rayon : ${cylinder.radius.toStringAsFixed(2)}, Hauteur : ${cylinder.height.toStringAsFixed(2)}, Volume : ${cylinder.volume.toStringAsFixed(2)}))');
    });

    return;
  }

  //Mode interactif

  stdout.writeln(
      'Inspecter les cylindres pour l\'expérience.\n q pour quitter.\nRenseignez le rayon et la hauteur du cylindre séparés par un espace ');

  do {
    final input = stdin.readLineSync();

    if (input == 'q') {
      stdout.writeln('Fin du programme.');
      return;
    }

    try {
      final Cylinder cylinder = readStdinIntoCylinder(input);
      final report = reportIfCylinderIsAcceptedForExperiment(
          radius: cylinder.radius, height: cylinder.height);

      final line =
          '${report.padRight(20)} : (Rayon : ${cylinder.radius.toStringAsFixed(2)}, Hauteur : ${cylinder.height.toStringAsFixed(2)}, Volume : ${computeCylinderVolume(radius: cylinder.radius, height: cylinder.height).toStringAsFixed(2)}))';
      stdout.writeln(line);
    } on Exception catch (e) {
      stdout.writeln(e);
    }
  } while (true);
}

//Solution avant de transformer l'application en programme interactif et capable d'import CSV
// void main() {
//   var cylinders = [
//     (radius: 1, height: 3),
//     (radius: 8, height: 7),
//     (radius: 7, height: 7),
//     (radius: 7.1, height: 7),
//     (radius: 7.1, height: 2.5),
//     ];
//   var inspectedCylinders = cylinders.map((cylinder) {
//     return (
//       radius: cylinder.radius,
//       height: cylinder.height,
//       volume: computeCylinderVolume(radius: cylinder.radius, height: cylinder.height),
//       report: reportIfCylinderIsAcceptedForExperiment(
//           radius: cylinder.radius, height: cylinder.height)
//     );
//   });
//   inspectedCylinders.forEach((cylinder) {
//     print('${cylinder.report.padRight(20)} : (Rayon : ${cylinder.radius.toStringAsFixed(2)}, Hauteur : ${cylinder.height.toStringAsFixed(2)}, Volume : ${cylinder.volume.toStringAsFixed(2)}))');
//   });
// }
