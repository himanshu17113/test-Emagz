class SupportMsg{
 
  String? id;
  String? email;
  String? reason;
  String? message;
  String? ticketNumber;
  String? createdAt;
  String? updatedAt;
  int? v;
  SupportMsg(
      {
        this.id,
        this.email,
        this.reason,
        this.message,
        this.ticketNumber,
        this.createdAt,
        this.updatedAt,
        this.v
      });
  SupportMsg.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? (json['_id']) : null;
    email = json['email'] != null ? (json['email']) : null;
    reason = json['reason']!=null? (json["reason"]):null;
    createdAt= json['is_private'];
    updatedAt= json['_id'];
    ticketNumber = json['ticketNumber']!=null?(json['ticketNumber']):null;
    v= json['__v'];
    message=json['message']!=null? (json['message']):null;
  }
}