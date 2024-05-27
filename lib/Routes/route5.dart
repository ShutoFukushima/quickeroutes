import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Route5 extends StatefulWidget {
  final String routeName;
  final int fare; // Fare represented as an integer
  final String travelTime;
  final double distance;

  Route5({
    required this.routeName,
    required this.fare,
    required this.travelTime,
    required this.distance,
  });

  @override
  _Route5State createState() => _Route5State();
}

class _Route5State extends State<Route5> {
  bool isFavorite = false;
  late int _currentFare;
  late int _initialFare;

  @override
  void initState() {
    super.initState();
    _currentFare = widget.fare;
    _initialFare = widget.fare; // Store the initial fare value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Stack(
          children: [
            MapPage6(), // Display the map
            Positioned(
              left: 46.0,
              right: 46.0,
              bottom: 16.0,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 39, 1, 255).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(text: 'Max Fare - '),
                                TextSpan(
                                    text: 'P$_currentFare',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(text: 'Travel - '),
                                TextSpan(
                                    text: widget.travelTime,
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(text: 'Distance - '),
                                TextSpan(
                                    text: '${widget.distance.toString()}km',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      '_________________________________________________________',
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100.0,
                          width: 190.0,
                          child: Image.asset('images/jeep.png', height: 100, width: 400),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: Text(
                            widget.routeName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              right: 14.0,
              child: FloatingActionButton(
                onPressed: () {
                  _showFareModal(context);
                },
                backgroundColor: Colors.white,
                child: Icon(Icons.percent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFareModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fare Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Regular"),
                selected: _currentFare == _initialFare,
                // Highlight if current fare is initial fare
                onTap: () {
                  setState(() {
                    _currentFare = _initialFare; // Reset _currentFare to initial value
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Senior/Student/PWD"),
                selected: _currentFare == (_initialFare - 2),
                // Highlight if current fare is decreased
                onTap: () {
                  setState(() {
                    _currentFare -= 2;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
class MapPage6 extends StatelessWidget {
  const MapPage6({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: FlutterMap(
            options: const MapOptions(
              initialCenter:  const LatLng(10.668490, 122.948454),
              initialZoom: 14.2,
            ),
            children: [
              TileLayer(
                urlTemplate:
                'https://tile-{s}.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                subdomains: const [
                  'a',
                  'b',
                  'c'
                ], // Subdomains for load balancing
                userAgentPackageName: 'com.example.app',
              ),

              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      const LatLng(10.668490, 122.948454),
                      const LatLng(10.669280, 122.948811),
                      const LatLng(10.669645, 122.948984),
                      const LatLng(10.671883, 122.949881),
                      const LatLng(10.671827, 122.949864),
                      const LatLng(10.669126, 122.956267),
                      const LatLng(10.668732, 122.957182),
                      const LatLng(10.664932, 122.966040),
                      const LatLng(10.663703, 122.968883),
                      const LatLng(10.660768, 122.976377),
                      const LatLng(10.660729, 122.976611),
                      const LatLng(10.660977, 122.999212),
                      const LatLng(10.661027, 122.999714),
                      const LatLng(10.663510, 123.005842),
                      const LatLng(10.663947, 123.007354),
                      const LatLng(10.664448, 123.009548),
                      const LatLng(10.664685, 123.010820),
                      const LatLng(10.664896, 123.012209),
                      const LatLng(10.665189, 123.016077),
                    ],
                    color: Colors.green,
                    strokeWidth: 4,
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      const LatLng(10.665189, 123.016077),
                      const LatLng(10.664896, 123.012209),
                      const LatLng(10.664685, 123.010820),
                      const LatLng(10.664448, 123.009548),
                      const LatLng(10.663947, 123.007354),
                      const LatLng(10.663510, 123.005842),
                      const LatLng(10.661027, 122.999714),
                      const LatLng(10.660977, 122.999212),
                      const LatLng(10.660729, 122.976611),
                      const LatLng(10.660768, 122.976377),
                      const LatLng(10.663703, 122.968883),
                      const LatLng(10.664932, 122.966040),
                      const LatLng(10.668732, 122.957182),
                      const LatLng(10.669412, 122.955664),
                      const LatLng(10.668062, 122.955074),
                      const LatLng(10.668337, 122.954414),
                      const LatLng(10.668795, 122.953067),
                      const LatLng(10.666281, 122.951957),
                      const LatLng(10.667867, 122.948252),
                      const LatLng(10.668538, 122.948514),
                    ],
                    color: Colors.red,
                    strokeWidth: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}