class Conversation {
  String? sId;
  List<String>? members;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Conversation(
      {this.sId, this.members, this.createdAt, this.updatedAt, this.iV});

  Conversation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    members = json['members'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['members'] = this.members;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}