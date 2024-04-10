//Solution de l'exercice 6 avec la composition

//On isole la méthode getContent dans une interface (c'est le comportement qui change d'une implémentation à l'autre). On aura autant de classes que de stratégies (c'est a dire d'implémentations désirées de getContent())

abstract interface class HtmlContentStrategy {
  String getContent();
}

class HtmlDocument {
  HtmlContentStrategy _strategy;

//On utilise l'injection de dépendance dans le constructeur pour donner une stratégie à notre objet
  //On ne le fait plus par héritage (override getContent dans la classe enfant), on le fait par composition
  //HtmlDocument dispose d'une stratégie pour gérer le contenu
  HtmlDocument(this._strategy);

  String get html => "<html><body>$content</body></html>";

  String get content => '${_strategy.getContent()}';
}

class HelloContent implements HtmlContentStrategy {
  final String _message;
  HelloContent(this._message);

  String getContent() {
    return 'Hello $_message!';
  }
}

class Announcement implements HtmlContentStrategy {
  String getContent() {
    return '<p>Annonce importante ! </p>';
  }
}

void main() {
  final helloWorld = HtmlDocument(HelloContent('foo bar'));
  final announcement = HtmlDocument(Announcement());
  print(helloWorld.html);
  print(announcement.html);
}

    //Qu'avons nous gagné ici en passant par le pattern Strategy au lieu de l'héritage ?

    //- déjà nous avons remplacé l'héritage par la composition. L'héritage crée des couplages forts entre les classes (car les enfants héritent de l'implémentation): il faut override les méthodes parentes, parfois celle-ci n'ont pas de sens chez la classe enfant, etc. Il est difficile dans des situations plus complexes de résoudre ces problème de couplage (rappelez vous le problème Rectangle/Carré !)
    //- nous pouvons changer facilement "au runtime" d'implémentation (de stratégie) car la classe HtmlDocument n'a plus la responsabilité du contenu, seulement d'appeler la méthode getContent().
    //- comme nous travaillons vers une interface et non une implémentation (contrairement au cas de l'héritage),nous gardons une interface propre entre HtmlDocument et ses stratégies (getContent() uniquement)
    //- nous respectons le principe Ouvert/Fermé: on peut ajouter de nouvelles stratégies sans modifier le contexte (ici le contexte est l'objet HtmlDocument. Il serait possible de rajouter un setStrategy pour changer de stratégie sans créer une nouvelle instance de HtmlDocument. Dans le cas de l'héritage nous devons changer d'objet pour changer de contenu)