import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _loadUsersAsset() async {
  return await rootBundle.loadString('assets/users.json');
}

Future loadUsers() async {
  String jsonUsers = await _loadUsersAsset();
  List<Users> users = _parseJsonForUsers(jsonUsers);
  return users;
}

List<Users> _parseJsonForUsers(String jsonString) {
  List decoded = jsonDecode(jsonString);

  List<Users> returnUsers = new List<Users>();
  for (var i = 0; i < decoded.length; i++) {
    returnUsers.add(new Users(decoded[i]['id'], decoded[i]['username'],
        decoded[i]['email'], decoded[i]['password']));
  }
  return returnUsers;
}

class Users {
  final int id;
  final String username;
  final String email;
  final String password;
  double points;
  List<int> friends;

  Users(this.id, this.username, this.email, this.password);

  int getID(){
    return id;
  }
  String getUserName(){
    return username;
  }
  String getEmail(){
    return email;
  }
  double getPoints(){
    return points;
  }
  List<int> getAllFriends(){
    return friends;
  }
  int getFriendByID(int ID){
    for(int i = 0; i < friends.length; i++){
      if(friends[i] == ID){
        return friends[i];
      }
    }
    return null;
  }
}