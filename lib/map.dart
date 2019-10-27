import 'package:flutter/material.dart';
import 'data/pins_parser.dart' as pins;
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyMap());
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  // String icon = "assets/alien.png";
  final Map<String, Marker> _markers = {};
  Set<Circle> circles = new Set<Circle>();
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final locations = await pins.loadPins();
    setState(() {
      _markers.clear();
      for (var i = 0; i < locations.length; i++) {
        final marker = Marker(
          markerId: MarkerId(locations[i].name),
          position: LatLng(locations[i].lat, locations[i].lng),
          // icon: BitmapDescriptor.fromAsset(icon),
          infoWindow: InfoWindow(
              title: locations[i].eventType,
              snippet: locations[i].address,
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(locations[i].name),
                      content: Text(locations[i].address +
                          '\n' +
                          'Points Awarded:' +
                          locations[i].pointsAwarded.toString() +
                          '\n' +
                          'People Needed:' +
                          locations[i].peopleNeeded.toString()),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text('Attend Event'),
                          onPressed: () {
                            print('helloooo....');
                          },
                        )
                      ],
                    );
                  },
                );
              }),
        );
        circles.add(new Circle(
            circleId: CircleId(i.toString()),
            center: LatLng(locations[i].lat, locations[i].lng),
            radius: locations[i].peopleNeeded > 25 ? 100 : 50,
            fillColor: locations[i].eventType == 'Charity'
                ? Colors.red.withOpacity(0.3)
                : Colors.green.withOpacity(0.3),
            strokeColor: Colors.transparent));
        _markers[locations[i].name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Map of Alien Invasion'),
            backgroundColor: Colors.green[700],
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(53.483959, -2.244644),
              zoom: 15.0,
            ),
            markers: _markers.values.toSet(),
            circles: circles,
          ),
        ),
      );
}
