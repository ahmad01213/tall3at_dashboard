
import 'package:dashboard/Models/Service.dart';

import 'User.dart';

class Message{
  int id ;
  String senderId ;
  String recieverId ;
  String serviceId ;
  String message ;
  String type ;
  String date ;
  int readed ;
  Service service;
  User sender;
  User reciever;


  Message(
      this.senderId,
      this.recieverId,
      this.message,
      );

  Message.fromJson(json){
    message = json["message"];
    type = json["type"];
    senderId = json["senderId"].toString();
    serviceId = json["serviceId"].toString();
    recieverId = json["recieverId"].toString();
    date = json["date"];
    readed = json["readed"];
    try{
      id = json["id"];

      service = Service.fromJson(json['service']);
      sender = User.fromJson(json['sender']);
      reciever = User.fromJson(json['reciever']);
    }catch(e){

    }
  }
}