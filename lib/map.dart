import 'package:flutter/material.dart';
import 'data/pins_parser.dart' as pins;
import 'data/users_parser.dart' as users;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './home.dart';

class MyMap extends StatefulWidget {
  users.Users activeUser;
  MyMap(@required users.Users current){
    activeUser = current;
  }

  @override
  _MyMapState createState() => _MyMapState(activeUser);
}

class _MyMapState extends State<MyMap> {
  // String icon = "assets/alien.png";
  users.Users activeUser;
  _MyMapState(@required users.Users current){
    activeUser = current;
  }

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
              title: locations[i].eventType,
              snippet: locations[i].address,
              onTap: () {
                print('hellooooooo');
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
              actions: <Widget>[
                // action button
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomeHub(activeUser)),);
                  },
                )]
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
