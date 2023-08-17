import 'dart:convert';

class Conversation {
  Data? data;
  UserData? userData;
  ResentMessage? resentMessage;

  Conversation({
    this.data,
    this.userData,
    this.resentMessage,
  });

  factory Conversation.fromRawJson(String str) =>
      Conversation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        userData: json["userData"] == null
            ? null
            : UserData.fromJson(json["userData"]),
        resentMessage: json["resentMessage"] == null
            ? null
            : ResentMessage.fromJson(json["resentMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "userData": userData?.toJson(),
        "resentMessage": resentMessage?.toJson(),
      };
}

class Data {
  String? id;
  List<String>? members;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.members,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        members: json["members"] == null
            ? []
            : List<String>.from(json["members"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "members":
            members == null ? [] : List<dynamic>.from(members!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class ResentMessage {
  String? id;
  String? conversationId;
  String? sender;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ResentMessage({
    this.id,
    this.conversationId,
    this.sender,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ResentMessage.fromRawJson(String str) =>
      ResentMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResentMessage.fromJson(Map<String, dynamic> json) => ResentMessage(
        id: json["_id"],
        conversationId: json["conversationId"],
        sender: json["sender"],
        text: json["text"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "conversationId": conversationId,
        "sender": sender,
        "text": text,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class UserData {
  String? id;
  String? username;
  String? email;
  String? profilePic;

  UserData({
    this.id,
    this.username,
    this.email,
    this.profilePic,
  });

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePic: json["ProfilePic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "ProfilePic": profilePic,
      };
}
