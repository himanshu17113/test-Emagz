class Message {
  String? sId;
  String? conversationId;
  String? sender;
  String? text;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {this.sId,
        this.conversationId,
        this.sender,
        this.text,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    print("json");
    sId = json['_id'];
    conversationId = json['conversationId'];
    sender = json['sender'];
    text = json['text'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['conversationId'] = this.conversationId;
    data['sender'] = this.sender;
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}