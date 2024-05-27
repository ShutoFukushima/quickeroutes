import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Route3 extends StatefulWidget {
  final String routeName;
  final int fare; // Fare represented as an integer
  final String travelTime;
  final double distance;

  Route3({
    required this.routeName,
    required this.fare,
    required this.travelTime,
    required this.distance,
  });

  @override
  _Route3State createState() => _Route3State();
}

class _Route3State extends State<Route3> {
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
            MapPage4(), // Display the map
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

class MapPage4 extends StatelessWidget {
  const MapPage4({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: FlutterMap(
            options: const MapOptions(
              initialCenter: const LatLng(10.600472, 122.905806),
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
                      const LatLng(10.600472, 122.905806),
                      const LatLng(10.599806, 122.904083),
                      const LatLng(10.599389, 122.902528),
                      const LatLng(10.599081, 122.901954),
                      const LatLng(10.598834, 122.901713),
                      const LatLng(10.598731, 122.901692),
                      const LatLng(10.598602, 122.901686),
                      const LatLng(10.598423, 122.901713),
                      const LatLng(10.597165, 122.902099),
                      const LatLng(10.597062, 122.902209),
                      const LatLng(10.596556, 122.905136),
                      const LatLng(10.596540, 122.906404),
                      const LatLng(10.596419, 122.908955),
                      const LatLng(10.596519, 122.911356),
                      const LatLng(10.596556, 122.911581),
                      const LatLng(10.598476, 122.917602),
                      const LatLng(10.598531, 122.917838),
                      const LatLng(10.604288, 122.921116),
                      const LatLng(10.605968, 122.922114),
                      const LatLng(10.606677, 122.922385),
                      const LatLng(10.616526, 122.927894),
                      const LatLng(10.618288, 122.928786),
                      const LatLng(10.619189, 122.929086),
                      const LatLng(10.620120, 122.929183),
                      const LatLng(10.623122, 122.928880),
                      const LatLng(10.629170, 122.927539),
                      const LatLng(10.629499, 122.927549),
                      const LatLng(10.630380, 122.927670),
                      const LatLng(10.643676, 122.933595),
                      const LatLng(10.668774, 122.946165),
                      const LatLng(10.668405, 122.946987),
                      const LatLng(10.669546, 122.947486),
                      const LatLng(10.670215, 122.946105),
                      const LatLng(10.671163, 122.943968)

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
                      const LatLng(10.671163, 122.943968),
                      const LatLng(10.671650, 122.942493),
                      const LatLng(10.667942, 122.940965),
                      const LatLng(10.666723, 122.943563),
                      const LatLng(10.665360, 122.942635),
                      const LatLng(10.664788, 122.944038),
                      const LatLng(10.643676, 122.933595),
                      const LatLng(10.630380, 122.927670),
                      const LatLng(10.629499, 122.927549),
                      const LatLng(10.629170, 122.927539),
                      const LatLng(10.623122, 122.928880),
                      const LatLng(10.620120, 122.929183),
                      const LatLng(10.619189, 122.929086),
                      const LatLng(10.618288, 122.928786),
                      const LatLng(10.616526, 122.927894),
                      const LatLng(10.606677, 122.922385),
                      const LatLng(10.605968, 122.922114),
                      const LatLng(10.604288, 122.921116),
                      const LatLng(10.598531, 122.917838),
                      const LatLng(10.598476, 122.917602),
                      const LatLng(10.596556, 122.911581),
                      const LatLng(10.596519, 122.911356),
                      const LatLng(10.596419, 122.908955),
                      const LatLng(10.596540, 122.906404),
                      const LatLng(10.596556, 122.905136),
                      const LatLng(10.597062, 122.902209),
                      const LatLng(10.597165, 122.902099),
                      const LatLng(10.598423, 122.901713),
                      const LatLng(10.598602, 122.901686),
                      const LatLng(10.598731, 122.901692),
                      const LatLng(10.598834, 122.901713),
                      const LatLng(10.599081, 122.901954),
                      const LatLng(10.599389, 122.902528),
                      const LatLng(10.599806, 122.904083),
                      const LatLng(10.600472, 122.905806),
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