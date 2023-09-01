class Post {
  //Privacy? privacy;
  List<PollResults?>? pollResults;
  int? likeCount;
  String? sId;
  UserSchema? user;
  String? mediaType;
  String? mediaUrl;
  bool? enabledpoll;
  bool? showPollResults;
  int? setTimer;
  String? caption;
  //String? tagPrivacy;
  List<String?>? reacted;
  List<String?>? likes;
  List<String?>? shares;
  int? pollDuration;
  List<Comment?>? comments;

//   DateTime? createdAt;
//   DateTime? updatedAt;
//  // int? v;
  bool? isLike;

  Post(
      { //this.privacy,
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
      this.isLike
      // this.createdAt,
      // this.updatedAt,
      //  this.iV
      });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        //privacy: json["privacy"] == null ? null : Privacy.fromJson(json["privacy"]),
        pollResults: json["PollResults"] == null
            ? []
            : List<PollResults>.from(
                json["PollResults"]!.map((x) => PollResults.fromJson(x))),
        likeCount: json["LikeCount"],
        sId: json["_id"],
        user:
            json["userId"] == null ? null : UserSchema.fromJson(json["userId"]),
        mediaType: json["mediaType"],
        mediaUrl: json["mediaUrl"],
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
  int? yes;
  int? no;

  PollResults({this.yes, this.no});

  PollResults.fromJson(Map<String, dynamic> json) {
    yes = json['yes'];
    no = json['no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yes'] = yes;
    data['no'] = no;
    return data;
  }
}

class UserSchema {
  String? mobileNumber;
  String? loginOtp;
  String? personalTemplate;
  String? sId;
  String? username;
  String? email;
  String? dob;
  String? accountType;
  List<String?>? interestName;
  int? followers;
  int? followings;
  String? hirable;
  String? rating;
  String? reviews;
  String? poll;
  String? jobcreated;
  String? accountStatus;
  List<String?>? search;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? getstatedName;
  String? displayName;

  UserSchema(
      {this.mobileNumber,
      this.loginOtp,
      this.personalTemplate,
      this.sId,
      this.username,
      this.email,
      this.dob,
      this.accountType,
      this.interestName,
      this.followers,
      this.followings,
      this.hirable,
      this.rating,
      this.reviews,
      this.poll,
      this.jobcreated,
      this.accountStatus,
      this.search,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.getstatedName,
      this.displayName});

  UserSchema.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    loginOtp = json['login_otp'];
    personalTemplate = json['personalTemplate'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    dob = json['dob'];
    accountType = json['accountType'];
    //   interestName = json['interestName'].cast<String>();
    followers = json['Followers'];
    followings = json['Followings'];
    hirable = json['Hirable'];
    rating = json['Rating'];
    reviews = json['Reviews'];
    poll = json['Poll'];
    jobcreated = json['Jobcreated'];
    accountStatus = json['AccountStatus'];
    //  search = json['search'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    getstatedName = json['GetstatedName'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_number'] = mobileNumber;
    data['login_otp'] = loginOtp;
    data['personalTemplate'] = personalTemplate;
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['dob'] = dob;
    data['accountType'] = accountType;
    data['interestName'] = interestName;
    data['Followers'] = followers;
    data['Followings'] = followings;
    data['Hirable'] = hirable;
    data['Rating'] = rating;
    data['Reviews'] = reviews;
    data['Poll'] = poll;
    data['Jobcreated'] = jobcreated;
    data['AccountStatus'] = accountStatus;
    data['search'] = search;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['GetstatedName'] = getstatedName;
    data['displayName'] = displayName;
    return data;
  }
}

// class Comment {
//   String? userId;
//   String? text;
//   String? sId;
//   List<Comment?>? comments;

//   Comment({this.userId, this.text, this.sId, this.comments});

//   Comment.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     text = json['text'];
//     sId = json['_id'];

//     // if (json['Comments'] != null) {
//     //   comments = <Comment>[];
//     //   json['Comments'].forEach((v) {
//     //     comments?.add(Comment.fromJson(v));
//     //   });
//     // }
//     // else{
//     //    comments = <Comment>[];
//     // }
//   }

//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = Map<String, dynamic>();
//   //   data['userId'] = this.userId;
//   //   data['text'] = this.text;
//   //   data['_id'] = this.sId;
//   //   if (this.comments != null) {
//   //     data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
//   //   }
//   //   return data;
//   // }
// }
class Comment {
  UserSchema? userId;
  String? text;
  String? sId;
  List<Comment>? comments;
  DateTime? timestamp;

  Comment({
    this.userId,
    this.text,
    this.sId,
    this.comments,
    this.timestamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId:
            json["userId"] == null ? null : UserSchema.fromJson(json["userId"]),
        text: json["text"],
        sId: json["_id"],
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
