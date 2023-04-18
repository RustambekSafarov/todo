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
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': basicAuth,
  };
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
    final tok = jsonDecode(response.body);

    print(await response.body);
    print(tok);
    print(username);
    print(password);
    return tok['token'];
  } else {
    print(response.reasonPhrase);
    return 'Error';
  }
}

// User log out
// Future userLogout(){

// }

// Here we will get all todos
Future<List> getTodo(String token) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token'
  };
  print(token);
  http.Response response = await http.get(
    Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/createtodo/'),
    headers: headers,
  );
  if (response.statusCode == 200) {
    List todoList = jsonDecode(response.body);
    print(await (response.body));
    return todoList;
  } else {
    print(response.reasonPhrase);
    return [];
  }
}

// Here we will create todo
Future<void> createTodo(String title, String token) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token'
  };
  Map<String, dynamic> body = {
    'title': title,
  };

  http.Response response = await http.post(
      Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/createtodo/'),
      headers: headers,
      body: jsonEncode(body));

  if (response.statusCode == 200) {
    print(await (response.statusCode));
  } else {
    print(response.reasonPhrase);
    print(response.statusCode);
  }
}

Future<int> deleteTodo(int id, String token) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token'
  };

  http.Response response = await http.post(
    Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/deletetodo/$id/'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(await (response.body));
    return jsonDecode(response.body)['status'];
  } else {
    print(response.reasonPhrase);
    return 404;
  }
}

// Get all users
Future<List> getAllUser() async {
  var headers = {
    'Content-Type': 'application/json',
  };

  http.Response response = await http.get(
    Uri.parse('https://majidovdiyorbek.pythonanywhere.com/api/deletetodo/'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(await (response.body));
  } else {
    print(response.reasonPhrase);
  }

  final users = jsonDecode(response.body);
  print(users);
  return users;
}
