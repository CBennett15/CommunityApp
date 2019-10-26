import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _loadPinsAsset() async {
  return await rootBundle.loadString('assets/pins.json');
}

Future loadPins() async {
  String jsonPins = await _loadPinsAsset();
  List<Pins> pins = _parseJsonForPins(jsonPins);
  return pins;
}

List<Pins> _parseJsonForPins(String jsonString) {
  List decoded = jsonDecode(jsonString);

  List<Pins> returnPins = new List<Pins>();
  for (var i = 0; i < decoded.length; i++) {
    returnPins.add(new Pins(decoded[i]['lat'], decoded[i]['lng'],
        decoded[i]['name'], decoded[i]['address'], decoded[i]['eventType']));
  }
  return returnPins;
}

class Pins {
  final double lat;
  final double lng;
  final String name;
  final String address;
  String type;
  double pointsAwarded;
  String organizer;
  double peopleNeeded;

  Pins(this.lat, this.lng, this.name, this.address, this.type);
}
