import 'dart:convert';

import '../social_media/models/post_model.dart';

class Poll {
  Post? post;
  List<PollResult>? pollResults;
  PollCalculation? pollCalculation;

  Poll({
    this.post,
    this.pollResults,
    this.pollCalculation,
  });

  factory Poll.fromJson(String str) => Poll.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Poll.fromMap(Map<String, dynamic> json) => Poll(
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
        pollResults: json["PollResults"] == null ? [] : List<PollResult>.from(json["PollResults"]!.map((x) => PollResult.fromMap(x))),
        pollCalculation: json["pollCalculation"] == null ? null : PollCalculation.fromMap(json["pollCalculation"]),
      );

  Map<String, dynamic> toMap() => {
     //   "post": post?.toMap(),
        "PollResults": pollResults == null ? [] : List<dynamic>.from(pollResults!.map((x) => x.toMap())),
        "pollCalculation": pollCalculation?.toMap(),
      };
}

class PollCalculation {
  int? yesPercentage;
  int? noPercentage;

  PollCalculation({
    this.yesPercentage,
    this.noPercentage,
  });

  factory PollCalculation.fromJson(String str) => PollCalculation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollCalculation.fromMap(Map<String, dynamic> json) => PollCalculation(
        yesPercentage: json["yesPercentage"],
        noPercentage: json["noPercentage"],
      );

  Map<String, dynamic> toMap() => {
        "yesPercentage": yesPercentage,
        "noPercentage": noPercentage,
      };
}

class PollResult {
  String? userId;
  String? vote;
  String? id;
  DateTime? timestamp;

  PollResult({
    this.userId,
    this.vote,
    this.id,
    this.timestamp,
  });

  factory PollResult.fromJson(String str) => PollResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PollResult.fromMap(Map<String, dynamic> json) => PollResult(
        userId: json["userId"],
        vote: json["vote"],
        id: json["_id"],
        timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "vote": vote,
        "_id": id,
        "timestamp": timestamp?.toIso8601String(),
      };
}

// class Post {
//   Privacy? privacy;
//   Privacy? tagPrivacy;
//   String? id;
//   String? userId;
//   String? mediaType;
//   String? mediaUrl;
//   List<dynamic>? tags;
//   int? likeCount;
//   bool? enabledpoll;
//   bool? showPollResults;
//   int? setTimer;
//   String? caption;
//   List<dynamic>? postHide;
//   List<dynamic>? tagPeople;
//   List<dynamic>? reacted;
//   List<dynamic>? likes;
//   List<dynamic>? shares;
//   int? pollDuration;
//   List<dynamic>? comments;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   Post({
//     this.privacy,
//     this.tagPrivacy,
//     this.id,
//     this.userId,
//     this.mediaType,
//     this.mediaUrl,
//     this.tags,
//     this.likeCount,
//     this.enabledpoll,
//     this.showPollResults,
//     this.setTimer,
//     this.caption,
//     this.postHide,
//     this.tagPeople,
//     this.reacted,
//     this.likes,
//     this.shares,
//     this.pollDuration,
//     this.comments,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory Post.fromJson(String str) => Post.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Post.fromMap(Map<String, dynamic> json) => Post(
//         privacy: json["privacy"] == null ? null : Privacy.fromMap(json["privacy"]),
//         tagPrivacy: json["tag_privacy"] == null ? null : Privacy.fromMap(json["tag_privacy"]),
//         id: json["_id"],
//         userId: json["userId"],
//         mediaType: json["mediaType"],
//         mediaUrl: json["mediaUrl"],
//         tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
//         likeCount: json["LikeCount"],
//         enabledpoll: json["Enabledpoll"],
//         showPollResults: json["ShowPollResults"],
//         setTimer: json["setTimer"],
//         caption: json["caption"],
//         postHide: json["post_hide"] == null ? [] : List<dynamic>.from(json["post_hide"]!.map((x) => x)),
//         tagPeople: json["tagPeople"] == null ? [] : List<dynamic>.from(json["tagPeople"]!.map((x) => x)),
//         reacted: json["Reacted"] == null ? [] : List<dynamic>.from(json["Reacted"]!.map((x) => x)),
//         likes: json["Likes"] == null ? [] : List<dynamic>.from(json["Likes"]!.map((x) => x)),
//         shares: json["shares"] == null ? [] : List<dynamic>.from(json["shares"]!.map((x) => x)),
//         pollDuration: json["pollDuration"],
//         comments: json["Comments"] == null ? [] : List<dynamic>.from(json["Comments"]!.map((x) => x)),
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toMap() => {
//         "privacy": privacy?.toMap(),
//         "tag_privacy": tagPrivacy?.toMap(),
//         "_id": id,
//         "userId": userId,
//         "mediaType": mediaType,
//         "mediaUrl": mediaUrl,
//         "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//         "LikeCount": likeCount,
//         "Enabledpoll": enabledpoll,
//         "ShowPollResults": showPollResults,
//         "setTimer": setTimer,
//         "caption": caption,
//         "post_hide": postHide == null ? [] : List<dynamic>.from(postHide!.map((x) => x)),
//         "tagPeople": tagPeople == null ? [] : List<dynamic>.from(tagPeople!.map((x) => x)),
//         "Reacted": reacted == null ? [] : List<dynamic>.from(reacted!.map((x) => x)),
//         "Likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
//         "shares": shares == null ? [] : List<dynamic>.from(shares!.map((x) => x)),
//         "pollDuration": pollDuration,
//         "Comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

class Privacy {
  bool? everyone;
  bool? followers;
  bool? noOne;

  Privacy({
    this.everyone,
    this.followers,
    this.noOne,
  });

  factory Privacy.fromJson(String str) => Privacy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Privacy.fromMap(Map<String, dynamic> json) => Privacy(
        everyone: json["everyone"],
        followers: json["followers"],
        noOne: json["no_one"],
      );

  Map<String, dynamic> toMap() => {
        "everyone": everyone,
        "followers": followers,
        "no_one": noOne,
      };
}
