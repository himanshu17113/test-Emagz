import 'user_schema.dart';

class Post {
  //Privacy? privacy;
  List<PollResults?>? pollResults;
  int? likeCount;
  final String? sId;
  final UserSchema? user;
  final String? mediaType;
  final List<String?>? mediaUrl;
  final bool? enabledpoll;
  bool? showPollResults;
 final int? setTimer;
  final String? caption;
  //String? tagPrivacy;
  final List<String?>? reacted;
  List<String?>? likes;
  final List<String?>? shares;
  final dynamic pollDuration;
  List<Comment?>? comments;

  List<String>? customPollData;
 final bool? customPollEnabled;

//   DateTime? createdAt;
//   DateTime? updatedAt;
//  // int? v;
  bool? isLike;

  Post({
    //this.privacy,
    this.pollResults,
    this.sId,
    this.likeCount,
    this.user,
    this.mediaType,
    this.mediaUrl,
    this.enabledpoll,
    this.showPollResults,
    this.setTimer,
    this.caption,
    // this.tagPrivacy,
    this.reacted,
    this.likes,
    this.shares,
    this.pollDuration,
    this.comments,
    this.isLike,
    this.customPollData,
    this.customPollEnabled,

    // this.createdAt,
    // this.updatedAt,
    //  this.iV
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        //privacy: json["privacy"] == null ? null : Privacy.fromJson(json["privacy"]),
        pollResults: json["PollResults"] == null
            ? []
            : List<PollResults>.from(
                json["PollResults"]!.map((x) => PollResults.fromMap(x))),
        likeCount: json["LikeCount"],
        sId: json["_id"],
        user:
            json["userId"] == null ? null : UserSchema.fromJson(json["userId"]),
        mediaType: json["mediaType"],
        mediaUrl: json["mediaUrl"] == null
            ? []
            : List<String?>.from(json["mediaUrl"].map((x) => x)),
        enabledpoll: json["Enabledpoll"],
        showPollResults: json["ShowPollResults"],
        setTimer: json["setTimer"],
        caption: json["caption"],
        // tagPrivacy: json["tagPrivacy"],
        reacted: json["Reacted"] == null
            ? []
            : List<String?>.from(json["Reacted"].map((x) => x)),
        likes: json["Likes"] == null
            ? []
            : List<String?>.from(json["Likes"].map((x) => x)),
        shares: json["shares"] == null
            ? []
            : List<String?>.from(json["shares"].map((x) => x)),
        pollDuration: json["pollDuration"],
        comments: json["Comments"] == null
            ? []
            : List<Comment?>.from(
                json["Comments"].map((x) => Comment.fromJson(x))),
        customPollData: json["customPollData"] == null
            ? []
            : List<String>.from(json["customPollData"]!.map((x) => x)),
        customPollEnabled: json["customPollEnabled"],
        // createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        // updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        // v: json["__v"],
        isLike: json["isLike"],
      );

  // Post.fromJson(Map<String, dynamic> json) {
  //   privacy =
  //   json['privacy'] != null ? new Privacy.fromJson(json['privacy']) : null;
  //   pollResults = json['PollResults'] != null
  //       ? new PollResults.fromJson(json['PollResults'])
  //       : null;
  //   sId = json['_id'];
  //   user =
  //   json['userId'] != null ? new UserSchema.fromJson(json['userId']) : null;
  //   mediaType = json['mediaType'];
  //   mediaUrl = json['mediaUrl'];
  //   enabledpoll = json['Enabledpoll'];
  //   showPollResults = json['ShowPollResults'];
  //   setTimer = json['setTimer'];
  //   caption = json['caption'];
  //   tagPrivacy = json['tagPrivacy'];
  //   reacted = json['Reacted'].cast<String>();
  //   likes = json['Likes'].cast<String>();
  //   shares = json['shares'].cast<String>();
  //   pollDuration = json['pollDuration'];
  //   if (json['Comments'] != null) {
  //     comments = <Comment>[];
  //     json['Comments'].forEach((v) {
  //       comments!.add(new Comment.fromJson(v));
  //     });
  //   }
  //   // createdAt = json['createdAt'];
  //   // updatedAt = json['updatedAt'];
  //   // iV = json['__v'];
  // }
}

class Privacy {
  String? likesAndViews;
  String? hideLikeAndViewsControl;

  Privacy({this.likesAndViews, this.hideLikeAndViewsControl});

  Privacy.fromJson(Map<String, dynamic> json) {
    likesAndViews = json['likesAndViews'];
    hideLikeAndViewsControl = json['hideLikeAndViewsControl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likesAndViews'] = likesAndViews;
    data['hideLikeAndViewsControl'] = hideLikeAndViewsControl;
    return data;
  }
}

class PollResults {
  String? userId;
  String? vote;
  String? id;
  DateTime? timestamp;

  PollResults({
    this.userId,
    this.vote,
    this.id,
    this.timestamp,
  });

  factory PollResults.fromMap(Map<String, dynamic> json) => PollResults(
        userId: json["userId"],
        vote: json["vote"],
        id: json["_id"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "vote": vote,
        "_id": id,
        "timestamp": timestamp?.toIso8601String(),
      };
}

// class ComentPrivacy {
//   bool? everyone;
//   bool? youFollow;
//   bool? yourFollowers;
//   bool? followAndFollowers;
//   ComentPrivacy(
//       {this.everyone,
//       this.youFollow,
//       this.yourFollowers,
//       this.followAndFollowers});
//   ComentPrivacy.fromJson(Map<String, dynamic> json) {
//     everyone = json['everyone'];
//     youFollow = json['follow'];
//     yourFollowers = json['followers'];
//     followAndFollowers = json['follow_and_followers'];
//   }
// }

// class PostPrivacy {
//   bool? everyone;
//   bool? yourFollower;
//   bool? noOne;

//   PostPrivacy({this.everyone, this.yourFollower, this.noOne});

//   PostPrivacy.fromJson(Map<String, dynamic> json) {
//     everyone = json['everyone'];
//     yourFollower = json['followers'];
//     noOne = json['no_one'];
//   }
// }

class Comment {
 final UserSchema? userId;
 final String? text;
 final String? sId;
  List<Comment>? comments;

  List<String?>? likes;
final  DateTime? timestamp;

  Comment({
    this.userId,
    this.text,
    this.sId,
    this.likes,
    this.comments,
    this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId:
            json["userId"] == null ? null : UserSchema.fromJson(json["userId"]),
        text: json["text"],
        sId: json["_id"],
                likes: json["likes"] == null
            ? []
            : List<String?>.from(json["likes"].map((x) => x)),
        comments: json["Comments"] == null
            ? []
            : List<Comment>.from(
                json["Comments"]!.map((x) => Comment.fromJson(x))),
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId?.toJson(),
        "text": text,
        "_id": sId,
        "Comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "timestamp": timestamp?.toIso8601String(),
      };
}
