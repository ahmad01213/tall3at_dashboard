class Category{
  int id;
  String name;
  String image;
  Category.fromJson(json){
    id = json["Id"];
    name = json["Name"];
    image= json["Image"];
  }
}