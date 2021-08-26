// To parse this JSON data, do
//
//     final cards = cardsFromJson(jsonString);

import 'dart:convert';

List<Cards> cardsFromJson(String str) => List<Cards>.from(json.decode(str).map((x) => Cards.fromJson(x)));

String cardsToJson(List<Cards> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cards {
  Cards({
    this.id,
    this.userId,
    this.name,
    this.number,
    this.expiredAt,
    this.cvc,
    this.isSelected,
  });

  int id;
  int userId;
  String name;
  String number;
  String expiredAt;
  String cvc;
  bool isSelected;

  Cards copyWith({
    int id,
    String userId,
    String name,
    String number,
    String expiredAt,
    String cvc,
    bool isSelected,
  }) =>
      Cards(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        number: number ?? this.number,
        expiredAt: expiredAt ?? this.expiredAt,
        cvc: cvc ?? this.cvc,
      );

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
    id: json["id"] == null ? null : json["id"],
    userId: json["userId"] == null ? null : json["userId"],
    name: json["name"] == null ? null : json["name"],
    number: json["number"] == null ? null : json["number"],
    expiredAt: json["expiredAt"] == null ? null : json["expiredAt"],
    cvc: json["cvc"] == null ? null : json["cvc"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userId": userId == null ? null : userId,
    "name": name == null ? null : name,
    "number": number == null ? null : number,
    "expiredAt": expiredAt == null ? null : expiredAt,
    "cvc": cvc == null ? null : cvc,
  };
}
