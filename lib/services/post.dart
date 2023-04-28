// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// var f = File('env.json').readAsStringSync();
Future<String> getPoint() async {
  String textasset = "assets/file.json"; //path to text file asset
  String text = await rootBundle.loadString(textasset);

  return jsonDecode(text)['endPoint'];
}

var endPoint = ''; //Platform.environment;

// Create new user and take a token for todo
Future<String> createUser(String username, String password, String email, String first_name, String last_name) async {
  endPoint = await getPoint();
  Uri uri = Uri.parse('$endPoint/create/');
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
  final _token = jsonDecode(response.body);

  return _token['token'];
}

// Login to program
Future<String> userLogin(String username, String password) async {
  // print(f);
  endPoint = await getPoint();
  print(endPoint);
  Uri uri = Uri.parse('$endPoint/userlogin/');
  String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': basicAuth,
  };

  http.Response response = await http.post(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    final _token = jsonDecode(response.body);

    print(response.body);
    print(_token);
    print(username);
    print(password);
    return _token['token'];
  } else {
    final err = jsonDecode(response.body);
    print(response.reasonPhrase);
    return 'Error';
  }
}

// User log out
// Future userLogout() async {
//   endPoint = await getPoint();
//   Uri uri = Uri.parse('$endPoint/createtodo/');
// }

// Here we will get all todos
Future<List> getTodo(String token) async {
  endPoint = await getPoint();
  Uri uri = Uri.parse('$endPoint/createtodo/');
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };
  print(token);
  http.Response response = await http.get(
    uri,
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
  endPoint = await getPoint();
  Uri uri = Uri.parse('$endPoint/createtodo/');
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Token $token',
  };
  Map<String, dynamic> body = {
    'title': title,
  };

  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
  } else {
    print(response.reasonPhrase);
    print(response.statusCode);
  }
}

Future<int> deleteTodo(int id, String token) async {
  endPoint = await getPoint();
  Uri uri = Uri.parse('$endPoint/deletetodo/$id/');
  var headers = {'Content-Type': 'application/json', 'Authorization': 'Token $token'};

  http.Response response = await http.post(
    uri,
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
  endPoint = await getPoint();
  Uri uri = Uri.parse('$endPoint/deletetodo/');
  var headers = {
    'Content-Type': 'application/json',
  };

  http.Response response = await http.get(
    uri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }

  final _users = jsonDecode(response.body);
  print(_users);
  return _users;
}
