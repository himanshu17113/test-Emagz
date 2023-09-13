class NModel {
  String? id;
  String? notification_from;
  String? notification_to;
  String? title;
  String? message;
  bool? isActive;
  bool? isSeen;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NModel({
    this.id,
    this.notification_from,
    this.notification_to,
    this.title,
    this.message,
    this.isActive,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}
