import 'package:flutter/material.dart';
import 'package:hacktheplanet/home.dart';
import 'data/pins_parser.dart' as pins;
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyAccount());
}

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final title = 'My Account';

  Widget pair = Expanded(
    child: Column(
      // align the text to the left instead of centered
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Title', style: TextStyle(fontSize: 16),),
        Text('subtitle'),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => MaterialApp(

    title: title,
    home: Scaffold(
      appBar: AppBar(
        title: Text(title),
          actions: <Widget>[
      // action button
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomeHub()),);
        },
      )]
    ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Map'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Album'),
          ),
          ListTile(
            leading: Icon(Icons.score),
            title: Text('Phone'),
          ),
        ],
      ),
    ),
  );
}
