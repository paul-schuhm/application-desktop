//Premiere solution par héritage
class HtmlDocument {
  String getHtml() {
    return "<html><body>${getContent()}</body></html>";
  }

  String getContent() {
    return 'Hello !';
  }
}

class HelloMessage extends HtmlDocument {
  final String message;

  HelloMessage(this.message);

  @override
  String getContent() {
    return 'Hello, $message';
  }
}

class Announcement extends HtmlDocument {
  @override
  String getContent() {
    return '<p>Annonce importante ! </p>';
  }
}

void main() {
  final helloWorld = HelloMessage('world');
  print(helloWorld.getHtml());
  final announcement = Announcement();
  print(announcement.getHtml());
}
