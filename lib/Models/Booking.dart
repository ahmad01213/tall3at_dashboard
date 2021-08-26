import 'package:dashboard/Models/Service.dart';
import 'package:dashboard/Models/User.dart';

class Booking {
  int id;
  int serviceId;
  int userId;
  int status;
  int Sets;
  String createdAt;
  User user;
  Service service;

  Booking.fromJson(json) {
    id = json["id"];
    serviceId = json["ServiceId"];
    userId = json["UserId"];
    status = json["Status"];
    Sets = json["Sets"];
    createdAt = json["CreatedAt"].toString().split(" ")[0];
    if(json['service']!=null){
      service = Service.fromJson(json["service"]);
    }

    if(json["user"]!=null)user = User.fromJson(json["user"]);
  }
}
