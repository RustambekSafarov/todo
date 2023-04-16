import 'package:http/http.dart' as http;
import 'dart:convert';

// Create new user and take a token for todo
Future<String> createUser(
  String username,
  String password,
  String email,
  String first_name,
  String last_name,
) async {
  Uri uri = Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/create/');
  Map<String, String> headers = {'Content-Type': 'application/json'};
  Map<String, String> body = {
    'username': username,
    'password': password,
    'email': email,
    'first_name': first_name,
    'last_name': last_name,
  };
  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonEncode(body),
  );
  final token = jsonDecode(response.body);
  return token['token'];
}

// Login to program
Future<String> userLogin(String username, String password) async {
  Uri uri =
      Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/userlogin/');
  var headers = {'Content-Type': 'application/json'};
  Map<String, String> body = {
    'username': username,
    'password': password,
  };
  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    print(await response.body);
  } else {
    print(response.reasonPhrase);
  }
  final tok = jsonDecode(response.body);
  print(tok);
  print(username);
  print(password);
  return tok['token'];
}

// Here we will get all todos
Future<List> getTodo(String token) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token'
  };
  http.Response response = await http.get(
    Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/createtodo/'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(await (response.body));
  } else {
    print(response.reasonPhrase);
  }
  List<dynamic> todoList = jsonDecode(response.body);

  return todoList;
}

// Here we will create todo
Future<void> createTodo(String title, int id, String token) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token'
  };
  Map<String, String> body = {
    'title': title,
    'user': id.toString(),
  };

  http.Response response = await http.post(
      Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/createtodo/'),
      headers: headers,
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    print(await (response.body));
  } else {
    // print(response.reasonPhrase);
    print(response.statusCode);
  }
}

Future<void> deleteTodo(String id, String token) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token'
  };
  var body = {
    "id": int.parse(id),
  };
  http.Response response = await http.delete(
    Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/deletetodo/'),
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    print(await (response.body));
  } else {
    print(response.reasonPhrase);
  }
}
