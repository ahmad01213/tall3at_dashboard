import 'package:dashboard/Models/User.dart';

class Organizing{
  int id;
  String providerId;
  String organizerId;
  String status;
  String createdAt;
  User organizer;
  Organizing.fromJson(json){
    id= json['id'];
    providerId= json['providerId'];
    organizerId= json['organizerId'];
    status= json['status'];
    createdAt= json['createdAt'];
    organizer=User.fromJson(json['organizer']);
  }

}