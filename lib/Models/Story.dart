import 'User.dart';

class Story{

  int id;
  String videoUrl;
  String imageUrl;
  String userImage;
  String userName;
  User user;
  String createdAt;

  Story.fromJson(json){
    id = json["id"];
    videoUrl = json["VideoUrl"];
    userImage = json['user']["ProfileImage"];
    imageUrl = json["ImageUrl"];
    userName = json['user']["UserName"];
    createdAt = json["CreatedAt"];
    user = User.fromJson(json['user']);
  }
}