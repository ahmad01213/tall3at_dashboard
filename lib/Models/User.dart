
class User {
  String id;
  String username;
  String fullName;
  String email;
  String banarImage;
  String profileImage;
  String aboutText;
  String password;
  String gender;
  String phone;
  String Role;
  String IbanNumber;
  String IdentityNumber;
  String country;
  String bank;
  String city;
  bool Statuse;
  String knownAs;
  User({this.id,this.fullName, this.profileImage, this.aboutText, this.banarImage}){}
  User.fromJson(json) {
    username = json["UserName"];
    email = json["email"];
    fullName = json["FullName"];
    profileImage = json["ProfileImage"] ?? "a.jpg";
    id = json["id"].toString();
    // password = json['password'];
    Role = json['Role'];
    phone = json['Phone'];
    bank = json['Bank'];
    country = json['country'];
    Statuse = (json['Statuse']==1);
    city = json['City'];
    aboutText = json['AboutText'];
    banarImage = json['BanarImage'];
    IbanNumber = json['IbanNumber'];
    knownAs = json['knownAs'] ;

    print(Statuse);

  }
}

