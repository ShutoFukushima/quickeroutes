import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quickeroutes/tabs/home_tab.dart';
import 'package:http/http.dart' as http;
import 'package:quickeroutes/Routes/route1.dart';
import 'package:quickeroutes/Routes/route2.dart';
import 'package:quickeroutes/Routes/route3.dart';
import 'package:quickeroutes/Routes/route4.dart';
import 'package:quickeroutes/Routes/route5.dart';
import 'package:quickeroutes/Routes/route6.dart';


class RoutesTab extends StatefulWidget {
  @override
  _RoutesTabState createState() => _RoutesTabState();
}

class _RoutesTabState extends State<RoutesTab> {
  List<dynamic> routeData = [];

  @override
  void initState() {
    super.initState();
    fetchRouteData();
  }

  Future<void> fetchRouteData() async {
    final response = await http.get(
        Uri.parse("https://quickeroutes.000webhostapp.com/fetch_routes.php"));

    if (response.statusCode == 200) {
      setState(() {
        routeData = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load route data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: routeData.length,
        itemBuilder: (context, index) {
          final route = routeData[index];
          return ListTile(
            title: Text(route['rName'] ?? ''),
            subtitle: Text('Route ${route['rID'] ?? ''}'),
            leading: Icon(
                Icons.directions, color: Color.fromARGB(255, 39, 1, 255)),
            onTap: () {
              _handleRouteTap(context, route['rName']);
            },
          );
        },
      ),
    );
  }

  void _handleRouteTap(BuildContext context, String routeName) {
    final selectedRoute = routeData.firstWhere(
          (route) => route['rName'] == routeName,
      orElse: () => null,
    );

    if (selectedRoute != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Route1(
                routeName: routeName,
                fare: double.parse(selectedRoute['rPrice']).toInt(),
                // Parsing to double and then to int
                travelTime: selectedRoute['rTime'],
                distance: double.parse(selectedRoute['rDistance']),
              ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeTab()),
      );
    }
  }
}

