class NotificationModle{
  int id;
  String title;
  String image;
  String body;
  String metaData;
  bool isRead;
  String createdAt;
  NotificationModle.fromJson(json){
    id = json["id"];
    title = json["Title"];
    image = json["Image"];
    body = json["Body"];
    metaData = json["MetaData"];
    isRead = json["isRead"] ?? false;
    createdAt = json["CreatedAt"];
  }
}