//Solution avec interface

abstract class Surface {
  double area();
  double perimeter();
}

class Rectangle implements Surface {
  double _height;
  double _width;
  Rectangle(this._height, this._width);

  void set increaseWidthBy(int percent) {
    _width *= 1 + percent / 100;
  }

  void set increaseHeightBy(int percent) {
    _height *= 1 + percent / 100;
  }

  @override
  String toString() {
    return 'height=$_height,width=$_width,area=${area()}';
  }

  double area() {
    return _height * _width;
  }

  double perimeter() {
    return 2 * _height + 2 * _width;
  }
}

class Square implements Surface {
  double _size;

  Square(this._size);

  double area() {
    return _size * _size;
  }

  double perimeter() {
    return 4 * _size;
  }

  void increaseSizeBy(int percent) {
    _size *= 1 + percent / 100;
  }

  @override
  String toString() {
    return 'size=$_size,area=${area()}';
  }
}

void main() {
  List<Surface> surfaces = [Rectangle(1, 2), Square(1)];
  for (final surface in surfaces) {
    print(surface);
  }
}
