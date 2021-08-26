import 'package:dashboard/Models/User.dart';

class Following{
  int id;
  int userId;
  String followerId;
  User followedUser;
  Following.fromJson(json){
    id = json['id'];
    userId = json['userId'];
    followerId = json['followerId'];
    followedUser = User.fromJson(json['followedUser']);
  }
}