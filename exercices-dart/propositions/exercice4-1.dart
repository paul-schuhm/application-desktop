//Solution insatisfaisante avec l'héritage

class Rectangle {
  double _height;
  double _width;
  Rectangle(this._height, this._width);
  double get area => _height * _width;
  double get perimeter => 2 * _height + 2 * _width;

  void set increaseWidthBy(int percent) {
    _width *= 1 + percent / 100;
  }

  void set increaseHeightBy(int percent) {
    _height *= 1 + percent / 100;
  }

  @override
  String toString() {
    return 'height=$_height,width=$_width,area=$area';
  }
}

class Square extends Rectangle {
  //Square(double length, double width) : super(length, width);
  //Ou directement
  Square(double size) : super(size, size);

  //On veut essayer de maintenir height et width égales

  @override
  void set increaseWidthBy(int percent) {
    //Si on ne change que la Width, ce n'est plus un carré !
    //On doit changer les deux cotés ici, alors qu'on devrait changer qu'un seul !
    //Le problème c'est que ces setters n'ont pas de sens dans l'interface d'un carré
    super.increaseWidthBy = percent;
    super.increaseHeightBy = percent;
  }

  @override
  void set increaseHeightBy(int percent) {
    //Si on ne change que la Height, ce n'est plus un carré !
    //On doit changer les deux cotés ici, alors qu'on devrait changer qu'un seul !
    //Le problème c'est que ces setters n'ont pas de sens dans l'interface d'un carré
    super.increaseWidthBy = percent;
    super.increaseHeightBy = percent;
  }
}

void main() {
  final forms = [Rectangle(1, 2), Square(1)];
  for (final form in forms) {
    //Comme Square n'a qu'une dimension, on devrait changer les deux cotés simultanément
    //et le carré devrait avoir une surface de 4
    //Dans un cas, on modifie un coté (rectangle), dans l'autre on modifie les deux (carré)
    //L'interface n'est pas cohérente
    form.increaseWidthBy = 100;
    print(form);
  }
}

//On aurait d'autres solutions possibles : 