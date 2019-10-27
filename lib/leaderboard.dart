import 'package:flutter/material.dart';
import 'package:hacktheplanet/home.dart';
import 'data/users_parser.dart' as users;

class MyLeaderboard extends StatefulWidget {
  final users.Users activeUser;
  List<DataRow> tableRows;




  MyLeaderboard(this.activeUser){
    tableRows = new List<DataRow>();
//    getFriendsRows(activeUser);
  }
  @override
  _MyLeaderboardState createState() => _MyLeaderboardState();
}

class _MyLeaderboardState extends State<MyLeaderboard> {
  final title = 'My Account';
  List<DataRow> tableRows = new List<DataRow>();

  @override
  initState() {
    super.initState();
    getFriendsRows(widget.activeUser);
  }

  Future<void> getFriendsRows(users.Users user) async {
    print("newTest1");
    List<DataRow> tempRows = new List<DataRow>();
    final allFriends = await user.getAllFriends();
    print(allFriends.length);
    for (int i = 0; i < allFriends.length; i++) {
      print("newTest2");
      print(allFriends[i].username);
      tempRows.add(DataRow(
        cells: [
          DataCell(
            Text(allFriends[i].username),
          ),
          DataCell(
            Text(allFriends[i].points.toString()),
          ),
        ],
      ));
    }
    setState(() => {
      tableRows = tempRows
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
                  MaterialPageRoute(builder: (context) => MyHomeHub(widget.activeUser)),);
              },
            )]
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Points')),
        ],
        columnSpacing: 235,
        rows: tableRows,
      )
    )
  );
}