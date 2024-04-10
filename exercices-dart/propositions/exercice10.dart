import 'dart:convert';

import 'package:http/http.dart' as http;

final BaseURI = 'jsonplaceholder.typicode.com';

///Récupère et affiche les emails des auteurs des commentaires du post identifié par [postId]
void fetchEmailOfAuthorWhoCommented({required int postId}) async {
  final response = await http
      .read(Uri.https(BaseURI, '/posts/${postId.toString()}/comments'));
  //Voir la doc : https://api.dart.dev/stable/3.1.3/dart-convert/JsonDecoder-class.html
  final List<dynamic> comments = jsonDecode(response);
  final authorsEmails = comments.map((comment) => comment['email']);
  print(
      "- List of emails of authors who commented post $postId : ${authorsEmails}");
}

///Retourne le nombre d'utilisateurs de la plateforme
Future<int> fetchNumberOfUsers() async {
  final response = await http.read(Uri.https(BaseURI, '/users'));
  final List<dynamic> users = jsonDecode(response);
  return users.length;
}

///Récupère et affiche les posts de l'utilisateur identifié par [userId]
void fetchPostsOfUser({required int userId}) async {
  final response = await http
      .read(Uri.https(BaseURI, '/posts', {'userId': userId.toString()}));
  final List<dynamic> posts = jsonDecode(response);
  print("- User $userId has published ${posts.length} posts so far");
}

///Requête une ressource inexistante et échoue avec grâce
void fetchANonExistingRessource() async {
  //Soit on gere l'erreur avec try/catch
  // var response;
  // try {
  //   response =
  //       await http.read(Uri.https('jsonplaceholder.typicode.com', '/comment'));
  // } catch (error) {
  //   print("The ressource was not found. Error message : ${error}");
  // }
  //Soit avec le status code
  var response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', '/comment'));
  if (response.statusCode == 404) {
    print("The ressource was not found");
  }
}

void main() async {
  print("Building a small report...");
  fetchEmailOfAuthorWhoCommented(postId: 2);
  fetchPostsOfUser(userId: 3);
  print("Fetching data... Please wait a moment");
  final numberOfUsers = await fetchNumberOfUsers();
  print("Total users : $numberOfUsers");
}
