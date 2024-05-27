import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Route6 extends StatefulWidget {
  final String routeName;
  final int fare; // Fare represented as an integer
  final String travelTime;
  final double distance;

  Route6({
    required this.routeName,
    required this.fare,
    required this.travelTime,
    required this.distance,
  });

  @override
  _Route6State createState() => _Route6State();
}

class _Route6State extends State<Route6> {
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
            MapPage7(), // Display the map
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
class MapPage7 extends StatelessWidget {
  const MapPage7({Key? key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: FlutterMap(
            options: const MapOptions(
              initialCenter:  const LatLng(10.705811, 122.962619),
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
                      const LatLng(10.705811, 122.962619),
                      const LatLng(10.706001, 122.962391),
                      const LatLng(10.706844, 122.962396),
                      const LatLng(10.706794, 122.962267),
                      const LatLng(10.703611, 122.962199),
                      const LatLng(10.700240, 122.962174),
                      const LatLng(10.699363, 122.962141),
                      const LatLng(10.699004, 122.962104),
                      const LatLng(10.698409, 122.961991),
                      const LatLng(10.698103, 122.961946),
                      const LatLng(10.697808, 122.961846),
                      const LatLng(10.696018, 122.961122),
                      const LatLng(10.688180, 122.957995),
                      const LatLng(10.685077, 122.956715),
                      const LatLng(10.684028, 122.956265),
                      const LatLng(10.683831, 122.956697),
                      const LatLng(10.683678, 122.956941),
                      const LatLng(10.683417, 122.957166),
                      const LatLng(10.675278, 122.961189),
                      const LatLng(10.674877, 122.961154),
                      const LatLng(10.674421, 122.961101),
                      const LatLng(10.668259, 122.958429),
                      const LatLng(10.669418, 122.955702),
                      const LatLng(10.671190, 122.956555),
                      const LatLng(10.670189, 122.959349),
                      const LatLng(10.674303, 122.961164),
                      const LatLng(10.674468, 122.961233),
                      const LatLng(10.674773, 122.961265),
                      const LatLng(10.675420, 122.961271),
                      const LatLng(10.683641, 122.957119),
                      const LatLng(10.683772, 122.956969),
                      const LatLng(10.683946, 122.956684),
                      const LatLng(10.684080, 122.956396),
                      const LatLng(10.697799, 122.961915),
                      const LatLng(10.698453, 122.962103),
                      const LatLng(10.699201, 122.962205),
                      const LatLng(10.705785, 122.962393),
                      const LatLng(10.705787, 122.962717),
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
                      const LatLng(10.705811, 122.962619),
                      const LatLng(10.706001, 122.962391),
                      const LatLng(10.706844, 122.962396),
                      const LatLng(10.706794, 122.962267),
                      const LatLng(10.703611, 122.962199),
                      const LatLng(10.700240, 122.962174),
                      const LatLng(10.699363, 122.962141),
                      const LatLng(10.699004, 122.962104),
                      const LatLng(10.698409, 122.961991),
                      const LatLng(10.698103, 122.961946),
                      const LatLng(10.697808, 122.961846),
                      const LatLng(10.696018, 122.961122),
                      const LatLng(10.688180, 122.957995),
                      const LatLng(10.685077, 122.956715),
                      const LatLng(10.684028, 122.956265),
                      const LatLng(10.683831, 122.956697),
                      const LatLng(10.683678, 122.956941),
                      const LatLng(10.683417, 122.957166),
                      const LatLng(10.675278, 122.961189),
                      const LatLng(10.674877, 122.961154),
                      const LatLng(10.674421, 122.961101),
                      const LatLng(10.668259, 122.958429),
                      const LatLng(10.669418, 122.955702),
                      const LatLng(10.671190, 122.956555),
                      const LatLng(10.670189, 122.959349),
                      const LatLng(10.674303, 122.961164),
                      const LatLng(10.674468, 122.961233),
                      const LatLng(10.674773, 122.961265),
                      const LatLng(10.675420, 122.961271),
                      const LatLng(10.683641, 122.957119),
                      const LatLng(10.683772, 122.956969),
                      const LatLng(10.683946, 122.956684),
                      const LatLng(10.684080, 122.956396),
                      const LatLng(10.697799, 122.961915),
                      const LatLng(10.698453, 122.962103),
                      const LatLng(10.699201, 122.962205),
                      const LatLng(10.705785, 122.962393),
                      const LatLng(10.705787, 122.962717),
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


