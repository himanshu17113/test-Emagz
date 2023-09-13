import 'dart:convert';

class NotificationModel {
  String? id;
  Notification? notificationFrom;
  Notification? notificationTo;
  String? title;
  String? message;
  bool? isActive;
  bool? isSeen;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NotificationModel({
    this.id,
    this.notificationFrom,
    this.notificationTo,
    this.title,
    this.message,
    this.isActive,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(String str) => NotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromMap(Map<String, dynamic> json) => NotificationModel(
        id: json["_id"],
        notificationFrom: json["notification_from"] == null ? null : Notification.fromMap(json["notification_from"]),
        notificationTo: json["notification_to"] == null ? null : Notification.fromMap(json["notification_to"]),
        title: json["title"],
        message: json["message"],
        isActive: json["isActive"],
        isSeen: json["isSeen"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "notification_from": notificationFrom?.toMap(),
        "notification_to": notificationTo?.toMap(),
        "title": title,
        "message": message,
        "isActive": isActive,
        "isSeen": isSeen,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Notification {
  String? id;
  String? username;
  String? email;
  String? profilePic;
  String? displayName;

  Notification({
    this.id,
    this.username,
    this.email,
    this.profilePic,
    this.displayName,
  });

  factory Notification.fromJson(String str) => Notification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notification.fromMap(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profilePic: json["ProfilePic"],
        displayName: json["displayName"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "username": username,
        "email": email,
        "ProfilePic": profilePic,
        "displayName": displayName,
      };
}
 