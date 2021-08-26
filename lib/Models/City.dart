
class City{
  String name;
  String country;
  City.fromJson(json){
    name = json['name'];
    country = json['country'];
  }
}