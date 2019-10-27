import 'package:flutter/material.dart';
import 'package:hacktheplanet/home.dart';
import 'data/users_parser.dart' as users;

class MyInvite extends StatefulWidget {
  final users.Users activeUser;
  List<DataRow> tableRows;

  MyInvite(this.activeUser){
    tableRows = new List<DataRow>();
//    getFriendsRows(activeUser);
  }
  @override
  _MyInviteState createState() => _MyInviteState();
}

class _MyInviteState extends State<MyInvite> {
  final title = 'Invite Friends';
  List<DataRow> tableRows = new List<DataRow>();

  @override
  initState() {
    super.initState();
    getFriendsRows(widget.activeUser);
  }

  Future<void> getFriendsRows(users.Users user) async {
    List<DataRow> tempRows = new List<DataRow>();
    final allFriends = await user.getAllFriends();
    print(allFriends.length);
    for (int i = 0; i < allFriends.length; i++) {
      print(allFriends[i].username);
      tempRows.add(DataRow(
        cells: [
          DataCell(
            Text(allFriends[i].username),
          ),
          DataCell(
            Text(allFriends[i].points.toString()),
          ),
          DataCell(
            Checkbox(
              activeColor: Colors.black,
              checkColor: Colors.lightGreen,
            )
          )
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
              title: Text('Invite Friends'),
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
              DataColumn(label: Text('Invite')),
            ],
            columnSpacing: 235,
            rows: tableRows,
          )
      )
  );
}