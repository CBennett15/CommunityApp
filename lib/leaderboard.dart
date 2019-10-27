import 'package:flutter/material.dart';
import 'package:hacktheplanet/home.dart';
import 'data/users_parser.dart' as users;

class MyLeaderboard extends StatefulWidget {
  final users.Users activeUser;
  List<DataRow> tableRows;

  Future<void> getFriendsRows(users.Users user) async {
    final allFriends = await user.getAllFriends();
    print(allFriends.length);
    allFriends.sort((a,b) => a.points.compareTo(b.points));
    for (int i = 0; i < allFriends.length; i++) {
      print(allFriends[i].username);
      tableRows.add(DataRow(
        cells: [
          DataCell(
            Text(allFriends[i].username),
          ),
          DataCell(
            Text(allFriends[i].points),
          ),
        ],
      ));
    }
  }

  MyLeaderboard(this.activeUser){
    tableRows = new List<DataRow>();
    getFriendsRows(activeUser);
  }
  @override
  _MyLeaderboardState createState() => _MyLeaderboardState();
}

class _MyLeaderboardState extends State<MyLeaderboard> {
  final title = 'My Account';
  List<DataRow> tableRows;
  users.Users activeUser;

  @override
  initState() {
    super.initState();
    tableRows = widget.tableRows;
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
      body: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Points')),
        ],
        rows: tableRows
      )
    )
  );
}