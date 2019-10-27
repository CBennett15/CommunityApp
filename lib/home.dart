import 'package:flutter/material.dart';
import 'package:hacktheplanet/leaderboard.dart';
import './map.dart';
import './account.dart';
import 'data/users_parser.dart' as users;

class MyHomeHub extends StatelessWidget {
  final users.Users activeUser;
  MyHomeHub(this.activeUser);

  @override
  Widget build(BuildContext context) {
  Widget bigCircle = new Container(
  width: 400.0,
  height: 400.0,
  decoration: new BoxDecoration(
  color: Colors.orange,
  shape: BoxShape.circle,
  ),
  );

  return new Material(
    color: Colors.blue,
      child: new Center(
        child: new Stack(
          children: <Widget>[
            bigCircle,
            new Positioned(
            child: new CircleButton(onTap: () => print("Help"), iconData: Icons.help),
            top: 240.0,
            left: 130.0,
            ),
            new Positioned(
            child: new CircleButton(onTap: () => print("Rewards"), iconData: Icons.timer),
            top: 120.0,
            left: 10.0,
            ),
            new Positioned(
            child: new CircleButton(onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyLeaderboard(activeUser)),
            ), iconData: Icons.list),
            top: 120.0,
            right: 10.0,
            ),
            new Positioned(
            child: new CircleButton(onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyMap(activeUser)),
            ), iconData: Icons.map),
            top: 10.0,
            left: 130.0,
            ),
            new Positioned(
            child: new CircleButton(onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAccount(activeUser)),
            ), iconData: Icons.face),
            top: 120.0,
            left: 130.0,
            ),
          ],
        ),
      ),
    );
  }
}


class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 100.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}

