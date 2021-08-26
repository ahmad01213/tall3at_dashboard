class Comment {
  int id;
  int rate;
  String comment;
  int userId;
  int orgId;
  String createdAt;
  String userName;



  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    comment = json['comment'];
    userId = json['userId'];
    orgId = json['orgId'];
    createdAt = json['createdAt'];
    userName = json['user_name'];
  }
}