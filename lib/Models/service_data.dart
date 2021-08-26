// To parse this JSON data, do
//
//     final serviceData = serviceDataFromJson(jsonString);

import 'dart:convert';



class ServiceData {
  bool isBooked;
  int allowedBookings;
  List<String> images=[];

  ServiceData.fromJson(json){
    isBooked = json['isBooked'];
    print(isBooked);
    allowedBookings = json['allowedBookings'];
  json['images'].forEach((item){
    images.add(item.toString());
    });

  }
}
