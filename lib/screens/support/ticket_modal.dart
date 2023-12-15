import 'dart:convert';

class Ticket {
  final String? id;
  final String? userId;
  final String? ticketNumber;
  final bool? ticketStaus;
  final String? ticketTitle;
  final DateTime? createdAt;

  Ticket({
    this.id,
    this.userId,
    this.ticketNumber,
    this.ticketStaus,
    this.ticketTitle,
    this.createdAt,
  });

  factory Ticket.fromJson(String str) => Ticket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        id: json["_id"],
        userId: json["userId"],
        ticketNumber: json["ticketNumber"],
        ticketStaus: json["ticketStaus"],
        ticketTitle: json["ticketTitle"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "userId": userId,
        "ticketNumber": ticketNumber,
        "ticketStaus": ticketStaus,
        "ticketTitle": ticketTitle,
        "createdAt": createdAt?.toIso8601String(),
      };
}
