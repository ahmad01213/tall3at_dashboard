import 'Booking.dart';

class Service {
  int id;
  String country;
  String image;
  List<String> payments;
  String name;
  String city;
  String userName;
  String userImage;
  String userBanar;
  String userSummery;
  int duration;
  String desc;
  String eventDate;
  String CreatedAt;
  bool expired ;
  int cost;
  bool statuse;
  String location;
  int categoryId;
  int userId;
  int bundleId;
  int actualCost;
  List<Booking> bookings = [];

  Service.fromJson(json) {
    id = json["Id"];
    name = json["Name"];
    image = json["Image"];
    if(json['user']!=null){
       userName = json['user']["UserName"] ?? "";
       userImage = json['user']["ProfileImage"] ?? "";
       userBanar = json['user']["BanarImage"] ?? "";
       userSummery = json["AboutText"];
    }

    country = json["Country"];
    duration = json["Duration"];
    CreatedAt = json["CreatedAt"].toString().split(" ")[0];
    desc = json["Desc"];
    eventDate = json["EventDate"].toString().split(" ")[0];
    cost = json["Cost"].toInt();
    expired = json["expired"];
    city = "الجبيل";
    statuse = json["Ctatuse"];
    location = json["Location"];
    payments = json["payments"].toString().split(",");
    categoryId = json["CategoryId"];
    userId = json["UserId"];
    bundleId = json["BundleId"];
    actualCost= json["Cost"].toInt() ;

   if(json['bookings']!=null) json['bookings'].forEach((element) {
      bookings.add(Booking.fromJson(element));
    });
  }
}
