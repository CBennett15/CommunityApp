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
  final Map<String, Marker> _markers = {};
  Set<Circle> circles = new Set<Circle>();
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final locations = await pins.loadPins();
    print(locations[0].name);
    setState(() {
      _markers.clear();
      for (var i = 0; i < locations.length; i++) {
        final marker = Marker(
          markerId: MarkerId(locations[i].name),
          position: LatLng(locations[i].lat, locations[i].lng),
          infoWindow: InfoWindow(
            title: locations[i].name,
            snippet: locations[i].address,
          ),
        );
        circles.add(new Circle(
            circleId: CircleId(i.toString()),
            center: LatLng(locations[i].lat, locations[i].lng),
            radius: 25,
            fillColor: Colors.teal[50]));
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
              zoom: 17.0,
            ),
            markers: _markers.values.toSet(),
            circles: circles,
          ),
        ),
      );
}
