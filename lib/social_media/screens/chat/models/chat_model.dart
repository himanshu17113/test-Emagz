// To parse this JSON data, do
//
//     final conversation = conversationFromMap(jsonString);

import 'dart:convert';

class Conversation {
  List<String>? members;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  Conversation({
    this.members,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Conversation.fromJson(String str) => Conversation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
        members: json["members"] == null ? [] : List<String>.from(json["members"]!.map((x) => x)),
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
