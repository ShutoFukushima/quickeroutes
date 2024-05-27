import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Route1 extends StatefulWidget {
  final String routeName;
  final int fare; // Fare represented as an integer
  final String travelTime;
  final double distance;

  Route1({
    required this.routeName,
    required this.fare,
    required this.travelTime,
    required this.distance,
  });

  @override
  _Route1State createState() => _Route1State();
}

class _Route1State extends State<Route1> {
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
            MapPage2(), // Display the map
            Positioned(
              left: 46.0,
              right: 46.0,
              bottom: 16.0,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
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
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(text: 'Max Fare - '),
                                TextSpan(text: 'P$_currentFare ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(text: 'Travel - '),
                                TextSpan(text: '${widget.travelTime} ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
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
                          child: Image.asset(
                              'images/jeep.png', height: 100, width: 400),
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
                    _currentFare =
                        _initialFare; // Reset _currentFare to initial value
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

class MapPage2 extends StatelessWidget {
  const MapPage2({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(10.625639, 122.9625),
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
                      const LatLng(10.625639, 122.9625),
                      const LatLng(10.632889, 122.962278),
                      const LatLng(10.633056, 122.960167),
                      const LatLng(10.635167, 122.957944),
                      const LatLng(10.647556, 122.935361),
                      const LatLng(10.667639, 122.945556),
                      const LatLng(10.667306, 122.946278)
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
                      const LatLng(10.667306, 122.946278),
                      const LatLng(10.667222, 122.9465),
                      const LatLng(10.662944, 122.944806),
                      const LatLng(10.661861, 122.947194),
                      const LatLng(10.659694, 122.946139),
                      const LatLng(10.661417, 122.942361),
                      const LatLng(10.647556, 122.935361),
                      const LatLng(10.635167, 122.957944),
                      const LatLng(10.633056, 122.960167),
                      const LatLng(10.632889, 122.962278),
                      const LatLng(10.632472, 122.966361),
                      const LatLng(10.632889, 122.962278),
                      const LatLng(10.625639, 122.9625)
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