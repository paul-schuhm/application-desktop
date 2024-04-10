import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  ///Monter le widget racine
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ///Notre état mutable
  List<int>? numbers;

  ///On surcharge une méthode prévue pour initialiser
  ///l'état du widget
  @override
  void initState() {
    super.initState();
    //Initialiser un générateur de nombre aléatoire
    final random = Random();

    ///Initialiser la liste de nombres
    numbers = List.generate(200, (i) => random.nextInt(100));

    executeEveryXseconds(1);
  }

  ///Retire un ensemble de nombres aléatoires toutes les X secondes
  void executeEveryXseconds(int seconds) {
    Timer.periodic(Duration(seconds: seconds), (timer) {
      rerollNumbers();
    });
  }

  ///Changement d'état notifié au framework pour repeindre l'UI
  ///et afficher la nouvelle liste de nombres
  void rerollNumbers() {
    final random = Random();

    ///Appeler setState (fourni par la classe State)
    setState(() {
      numbers = List.generate(200, (i) => random.nextInt(100));
    });
  }

  @override
  Widget build(BuildContext context) {
    final numberWidgets = numbers!
        .map(
          (e) => Text(
            e.toString(),
            textDirection: TextDirection.ltr,
          ),
        )
        .toList();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(20),
          child: ListView(
            children: numberWidgets,
          )),
    );
  }
}
