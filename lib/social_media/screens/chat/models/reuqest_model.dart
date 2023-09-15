class Requests{
  String? id;
  String? status;
  sender_id? sender;
  reciever_id? reciever;
  Requests(
      this.id,
      this.sender,
      this.reciever,
      this.status
      );
  Requests.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? (json['_id']) : null;
    status= json['status']!=null? (json['status']):null;
    sender= json['senderId']!=null?sender_id(
      id:json['senderId']['_id'],
      username:json['senderId']['username'],
      email: json['senderId']['email'],
      ProfilePic: json['senderId']['ProfilePic'],
      displayName: json['senderId']['displayName']
    ):null;
    reciever= json['receiverId']!=null?reciever_id(
        id:json['receiverId']['_id'],
        username:json['receiverId']['username'],
        email: json['receiverId']['email'],
        ProfilePic: json['receiverId']['ProfilePic'],
        displayName: json['receiverId']['displayName']
    ):null;

  }
}
class sender_id{

  String? id;
  String ?username;
  String? email;
  String? ProfilePic;
  String? displayName;
  sender_id(
  {
    this.id,
    this.email,
    this.username,
    this.displayName,
    this.ProfilePic
}
      );
}
class reciever_id{
  String? id;
  String ?username;
  String? email;
  String? ProfilePic;
  String? displayName;
  reciever_id(
  {
    this.id,
    this.email,
    this.username,
    this.displayName,
    this.ProfilePic
}
      );
}
