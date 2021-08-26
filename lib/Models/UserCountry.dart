

class UserContry{
  String name;
  String code;
  UserContry.fromJson(json){
    name = json['name'];
    code = json['code'];
  }
}
