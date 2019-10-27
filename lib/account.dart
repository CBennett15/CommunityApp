import 'package:flutter/material.dart';
import 'package:hacktheplanet/home.dart';
import 'data/users_parser.dart' as users;

class MyAccount extends StatefulWidget {
  final users.Users activeUser;
  MyAccount(this.activeUser);
  @override
  _MyAccountState createState() => _MyAccountState(activeUser);
}

class _MyAccountState extends State<MyAccount> {
  final title = 'My Account';
  users.Users activeUser;
    _MyAccountState(users.Users current){
    activeUser = current;
  }

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
              MaterialPageRoute(builder: (context) => MyHomeHub(activeUser)),);
        },
      )]
    ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text(activeUser.getUserName()),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(activeUser.getEmail()),
          ),
          ListTile(
            leading: Icon(Icons.score),
            title: Text(activeUser.getPoints().toString()),
          ),
        ],
      ),
    ),
  );
}
