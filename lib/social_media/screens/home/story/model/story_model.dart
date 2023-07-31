class Story {
  String? sId;
  String? userId;
  String? mediaType;
  String? mediaUrl;
  List<String>? likes;
  List<String>? shares;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? username;

  Story(
      {this.sId,
        this.userId,
        this.mediaType,
        this.mediaUrl,
        this.likes,
        this.shares,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.username});

  Story.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    mediaType = json['mediaType'];
    mediaUrl = json['mediaUrl'];
    likes = json['Likes'].cast<String>();
    shares = json['shares'].cast<String>();
    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    username = json['username'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['mediaType'] = this.mediaType;
    data['mediaUrl'] = this.mediaUrl;
    data['Likes'] = this.likes;
    data['shares'] = this.shares;
    if (this.comments != null) {
      data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['username'] = this.username;
    return data;
  }
}

class Comments {
  String? userId;
  String? text;
  List<String>? reactions;
  String? sId;
  List<Comments>? comments;
  String? timestamp;

  Comments(
      {this.userId,
        this.text,
        this.reactions,
        this.sId,
        this.comments,
        this.timestamp});

  Comments.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    text = json['text'];
    // reactions = json['reactions'].cast<String>();
    sId = json['_id'];
    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['text'] = this.text;
    data['reactions'] = this.reactions;
    data['_id'] = this.sId;
    if (this.comments != null) {
      data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}
