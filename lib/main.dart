import 'package:flutter/material.dart';
import 'package:quickeroutes/tabs/home_tab.dart';
import 'package:quickeroutes/tabs/route_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickeroutes/Authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool validation = prefs.getBool('validation') ?? false;

  runApp(MyApp(validation: validation));
}

class MyApp extends StatelessWidget {
  final bool validation;

  const MyApp({super.key, required this.validation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quickeroutes',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: validation ? '/home' : '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    RoutesTab(),
    Container(), // Placeholder for the logout button
  ];

  void _onItemTapped(int index) {
    if (index == _pages.length - 1) {
      _showLogoutDialog();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('validation', false);
    Navigator.pushReplacementNamed(context, '/');
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}

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
