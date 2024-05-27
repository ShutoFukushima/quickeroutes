import 'package:flutter/material.dart';
import 'package:quickeroutes/Authentication/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String id;
  final String username;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['usrId'],
      username: json['usrName'],
      password: json['usrPassword'],
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  final formKey = GlobalKey<FormState>();

  Future<List<User>> _fetchUsers() async {
    final response = await http.get(Uri.parse('http://quickeroutes.000webhostapp.com/fetch_users.php'));

    if (response.statusCode == 200) {
      Iterable data = json.decode(response.body);
      return List<User>.from(data.map((model) => User.fromJson(model)));
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _login() async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    try {
      final users = await _fetchUsers();
      bool validation = false;

      for (var user in users) {
        if (user.username == username && user.password == password) {
          validation = true;
          break;
        }
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('validation', validation);

      if (validation) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          isLoginTrue = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    "images/logo.png",
                    width: 210,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2),
                    ),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                        child: const Text("SIGN UP"),
                      ),
                    ],
                  ),
                  isLoginTrue
                      ? const Text(
                    "Username or password is incorrect",
                    style: TextStyle(color: Colors.red),
                  )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}