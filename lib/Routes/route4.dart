import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Route4 extends StatefulWidget {
  final String routeName;
  final int fare; // Fare represented as an integer
  final String travelTime;
  final double distance;

  Route4({
    required this.routeName,
    required this.fare,
    required this.travelTime,
    required this.distance,
  });

  @override
  _Route4State createState() => _Route4State();
}

class _Route4State extends State<Route4> {
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
            MapPage5(), // Display the map
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

class MapPage5 extends StatelessWidget {
  const MapPage5({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: FlutterMap(
            options: const MapOptions(
              initialCenter: const LatLng(10.682223, 122.957743),
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
                      const LatLng(10.682223, 122.957743),
                      const LatLng(10.675518, 122.961108),
                      const LatLng(10.674489, 122.961125),
                      const LatLng(10.668248, 122.958399),
                      const LatLng(10.668232, 122.958388),
                      const LatLng(10.671241, 122.950988),
                      const LatLng(10.668556, 122.949887),
                      const LatLng(10.669014, 122.948854),
                      const LatLng(10.669557, 122.947515),
                      const LatLng(10.670187, 122.946150),
                      const LatLng(10.670311, 122.945976),
                      const LatLng(10.670556, 122.945372),
                      const LatLng(10.670556, 122.945372),
                      const LatLng(10.670796, 122.944761),
                      const LatLng(10.671165, 122.943911),
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
                      const LatLng(10.671165, 122.943911),
                      const LatLng(10.669363, 122.941491),
                      const LatLng(10.668517, 122.943655),
                      const LatLng(10.668364, 122.943881),
                      const LatLng(10.668061, 122.944460),
                      const LatLng(10.666770, 122.943532),
                      const LatLng(10.666156, 122.944827),
                      const LatLng(10.666874, 122.945198),
                      const LatLng(10.666437, 122.946170),
                      const LatLng(10.662959, 122.944814),
                      const LatLng(10.661309, 122.948329),
                      const LatLng(10.660859, 122.949372),
                      const LatLng(10.659280, 122.948619),
                      const LatLng(10.658790, 122.949671),
                      const LatLng(10.659392, 122.950028),
                      const LatLng(10.659449, 122.950205),
                      const LatLng(10.660446, 122.950701),
                      const LatLng(10.660579, 122.950750),
                      const LatLng(10.660712, 122.950930),
                      const LatLng(10.660788, 122.951330),
                      const LatLng(10.660897, 122.951904),
                      const LatLng(10.661288, 122.954275),
                      const LatLng(10.661536, 122.955066),
                      const LatLng(10.661663, 122.955560),
                      const LatLng(10.661839, 122.955770),
                      const LatLng(10.663033, 122.956287),
                      const LatLng(10.665168, 122.957204),
                      const LatLng(10.665346, 122.957252),
                      const LatLng(10.668088, 122.958462),
                      const LatLng(10.668280, 122.958635),
                      const LatLng(10.669154, 122.958960),
                      const LatLng(10.669520, 122.959084),
                      const LatLng(10.670165, 122.959361),
                      const LatLng(10.674333, 122.961222),
                      const LatLng(10.675218, 122.961277),
                      const LatLng(10.675452, 122.961277),
                      const LatLng(10.675795, 122.961144),
                      const LatLng(10.677334, 122.960360),
                      const LatLng(10.679067, 122.959493),
                      const LatLng(10.680564, 122.962540),
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