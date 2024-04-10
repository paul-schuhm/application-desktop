//Source: Design Patterns: Elements of Reusable Object-Oriented Software (p121)
abstract interface class Document {
  void open();
  void close();
  void save();
  void modify();
}

class MyDocument implements Document {
  open() {
    print("MyDocument a été ouvert");
  }

  close() {
    print("MyDocument a été fermé");
  }

  save() {
    print("MyDocument a été enregistré");
  }

  modify() {
    print("MyDocument a été modifié");
  }
}

//Cette classe ne sait pas à l'avance quel type de document elle va devoir créer et manipuler (Factory)
abstract class Application {
  Document? _document;

  //Virtual constructor (autre nom du Pattern)
  Document createDocument();

  void newDocument() {
    _document = createDocument();
    _document?.open();
  }
}

//C'est à l'utilisateur de la classe de préciser quel implémentation de Document Application va manipuler
class ApplicationText extends Application {
  Document createDocument() {
    return MyDocument();
  }
}

class ApplicationImage extends Application {
  Document createDocument() {
    //Permet de proposer des Hooks pour les sous-classes de Application
    print("ApplicationImage Hook: quelle taille d\'image ?");
    return MyDocument();
  }
}

void main() {
  final myAppText = ApplicationText();
  myAppText.newDocument();

  final myAppImage = ApplicationImage();
  myAppImage.newDocument();
}
