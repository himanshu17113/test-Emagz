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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['conversationId'] = conversationId;
    data['sender'] = sender;
    data['text'] = text;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}