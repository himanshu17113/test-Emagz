class Story {
  UserId? userId;
  List<Stories>? stories;

  Story({this.userId, this.stories});

  Story.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.userId != null) {
  //     data['userId'] = this.userId!.toJson();
  //   }
  //   if (this.stories != null) {
  //     data['stories'] = this.stories!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

}

class UserId {
  RatingCount? ratingCount;
  CommentPrivacy? commentPrivacy;
  PostPrivacy? postPrivacy;
  PostPrivacy? mentionPrivacy;
  PostPrivacy? messagePrivacy;
  PostPrivacy? livePrivacy;
  StoryPrivacy? storyPrivacy;
  String? loginOtp;
  bool? isActive;
  String? isPrivate;
  String? sId;
  String? username;
  String? email;
  String? dob;
  String? password;
  String? accountType;
  List<String>? interestName;
  int? followers;
  int? followings;
  String? hirable;
  String? rating;
  String? reviews;
  String? poll;
  String? jobcreated;
  String? accountStatus;
 // List<Null>? search;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? getstatedName;
  String? businessLogo;
  String? businessName;
  String? businessType;
  String? forgetPassordOtp;
  String? mobileNumber;
  String? profilePic;
 // List<Null>? ratings;
  String? personalTemplate;

  UserId(
      {this.ratingCount,
      this.commentPrivacy,
      this.postPrivacy,
      this.mentionPrivacy,
      this.messagePrivacy,
      this.livePrivacy,
      this.storyPrivacy,
      this.loginOtp,
      this.isActive,
      this.isPrivate,
      this.sId,
      this.username,
      this.email,
      this.dob,
      this.password,
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
   //   this.search,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.getstatedName,
      this.businessLogo,
      this.businessName,
      this.businessType,
      this.forgetPassordOtp,
      this.mobileNumber,
      this.profilePic,
 //     this.ratings,
      this.personalTemplate});

  UserId.fromJson(Map<String, dynamic> json) {
    ratingCount = json['Rating_count'] != null ? RatingCount.fromJson(json['Rating_count']) : null;
    commentPrivacy = json['comment_privacy'] != null ? CommentPrivacy.fromJson(json['comment_privacy']) : null;
    postPrivacy = json['post_privacy'] != null ? PostPrivacy.fromJson(json['post_privacy']) : null;
    mentionPrivacy = json['mention_privacy'] != null ? PostPrivacy.fromJson(json['mention_privacy']) : null;
    messagePrivacy = json['message_privacy'] != null ? PostPrivacy.fromJson(json['message_privacy']) : null;
    livePrivacy = json['live_privacy'] != null ? PostPrivacy.fromJson(json['live_privacy']) : null;
    storyPrivacy = json['story_privacy'] != null ? StoryPrivacy.fromJson(json['story_privacy']) : null;
    loginOtp = json['login_otp'];
    isActive = json['is_active'];
    isPrivate = json['is_private'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    dob = json['dob'];
    password = json['password'];
    accountType = json['accountType'];
    interestName = json['interestName'].cast<String>();
    followers = json['Followers'];
    followings = json['Followings'];
    hirable = json['Hirable'];
    rating = json['Rating'];
    reviews = json['Reviews'];
    poll = json['Poll'];
    jobcreated = json['Jobcreated'];
    accountStatus = json['AccountStatus'];
    // if (json['search'] != null) {
    //   search = <Null>[];
    //   json['search'].forEach((v) {
    //     search!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    getstatedName = json['GetstatedName'];
    businessLogo = json['businessLogo'];
    businessName = json['businessName'];
    businessType = json['businessType'];
    forgetPassordOtp = json['forget_passord_otp'];
    mobileNumber = json['mobile_number'];
    profilePic = json['ProfilePic'];
    // if (json['Ratings'] != null) {
    //   ratings = <Null>[];
    //   json['Ratings'].forEach((v) {
    //     ratings!.add(new Null.fromJson(v));
    //   });
    // }
    personalTemplate = json['personalTemplate'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.ratingCount != null) {
  //     data['Rating_count'] = this.ratingCount!.toJson();
  //   }
  //   if (this.commentPrivacy != null) {
  //     data['comment_privacy'] = this.commentPrivacy!.toJson();
  //   }
  //   if (this.postPrivacy != null) {
  //     data['post_privacy'] = this.postPrivacy!.toJson();
  //   }
  //   if (this.mentionPrivacy != null) {
  //     data['mention_privacy'] = this.mentionPrivacy!.toJson();
  //   }
  //   if (this.messagePrivacy != null) {
  //     data['message_privacy'] = this.messagePrivacy!.toJson();
  //   }
  //   if (this.livePrivacy != null) {
  //     data['live_privacy'] = this.livePrivacy!.toJson();
  //   }
  //   if (this.storyPrivacy != null) {
  //     data['story_privacy'] = this.storyPrivacy!.toJson();
  //   }
  //   data['login_otp'] = this.loginOtp;
  //   data['is_active'] = this.isActive;
  //   data['is_private'] = this.isPrivate;
  //   data['_id'] = this.sId;
  //   data['username'] = this.username;
  //   data['email'] = this.email;
  //   data['dob'] = this.dob;
  //   data['password'] = this.password;
  //   data['accountType'] = this.accountType;
  //   data['interestName'] = this.interestName;
  //   data['Followers'] = this.followers;
  //   data['Followings'] = this.followings;
  //   data['Hirable'] = this.hirable;
  //   data['Rating'] = this.rating;
  //   data['Reviews'] = this.reviews;
  //   data['Poll'] = this.poll;
  //   data['Jobcreated'] = this.jobcreated;
  //   data['AccountStatus'] = this.accountStatus;
  //   if (this.search != null) {
  //     data['search'] = this.search!.map((v) => v.toJson()).toList();
  //   }
  //   data['createdAt'] = this.createdAt;
  //   data['updatedAt'] = this.updatedAt;
  //   data['__v'] = this.iV;
  //   data['GetstatedName'] = this.getstatedName;
  //   data['businessLogo'] = this.businessLogo;
  //   data['businessName'] = this.businessName;
  //   data['businessType'] = this.businessType;
  //   data['forget_passord_otp'] = this.forgetPassordOtp;
  //   data['mobile_number'] = this.mobileNumber;
  //   data['ProfilePic'] = this.profilePic;
  //   if (this.ratings != null) {
  //     data['Ratings'] = this.ratings!.map((v) => v.toJson()).toList();
  //   }
  //   data['personalTemplate'] = this.personalTemplate;
  //   return data;
  // }

}

class RatingCount {
  int? rating1;
  int? rating2;
  int? rating3;
  int? rating4;
  int? rating5;

  RatingCount({this.rating1, this.rating2, this.rating3, this.rating4, this.rating5});

  RatingCount.fromJson(Map<String, dynamic> json) {
    rating1 = json['Rating_1'];
    rating2 = json['Rating_2'];
    rating3 = json['Rating_3'];
    rating4 = json['Rating_4'];
    rating5 = json['Rating_5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Rating_1'] = rating1;
    data['Rating_2'] = rating2;
    data['Rating_3'] = rating3;
    data['Rating_4'] = rating4;
    data['Rating_5'] = rating5;
    return data;
  }
}

class CommentPrivacy {
  bool? everyone;
  bool? followers;
  bool? follow;
  bool? followAndFollowers;

  CommentPrivacy({this.everyone, this.followers, this.follow, this.followAndFollowers});

  CommentPrivacy.fromJson(Map<String, dynamic> json) {
    everyone = json['everyone'];
    followers = json['followers'];
    follow = json['follow'];
    followAndFollowers = json['follow_and_followers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['everyone'] = everyone;
    data['followers'] = followers;
    data['follow'] = follow;
    data['follow_and_followers'] = followAndFollowers;
    return data;
  }
}

class PostPrivacy {
  bool? everyone;
  bool? followers;
  bool? noOne;

  PostPrivacy({this.everyone, this.followers, this.noOne});

  PostPrivacy.fromJson(Map<String, dynamic> json) {
    everyone = json['everyone'];
    followers = json['followers'];
    noOne = json['no_one'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['everyone'] = everyone;
    data['followers'] = followers;
    data['no_one'] = noOne;
    return data;
  }
}

class StoryPrivacy {
  bool? everyone;
  bool? closeFriend;
  bool? specific;

  StoryPrivacy({this.everyone, this.closeFriend, this.specific});

  StoryPrivacy.fromJson(Map<String, dynamic> json) {
    everyone = json['everyone'];
    closeFriend = json['close_friend'];
    specific = json['specific'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['everyone'] = everyone;
    data['close_friend'] = closeFriend;
    data['specific'] = specific;
    return data;
  }
}

class Stories {
  String? sId;
  String? userId;
  String? mediaType;
  String? mediaUrl;
  List<String>? likes;
  //List<Null>? shares;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? likeCount;
  String? username;
  bool? isLike;

  Stories(
      {this.sId,
      this.userId,
      this.mediaType,
      this.mediaUrl,
      this.likes,
   //   this.shares,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.likeCount,
      this.username,
      this.isLike});

  Stories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    mediaType = json['mediaType'];
    mediaUrl = json['mediaUrl'];
    likes = json['Likes'].cast<String>();

    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    likeCount = json['LikeCount'];
    username = json['username'];
    isLike = json['isLike'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['userId'] = this.userId;
  //   data['mediaType'] = this.mediaType;
  //   data['mediaUrl'] = this.mediaUrl;
  //   data['Likes'] = this.likes;
  //   if (this.shares != null) {
  //     data['shares'] = this.shares!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.comments != null) {
  //     data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
  //   }
  //   data['createdAt'] = this.createdAt;
  //   data['updatedAt'] = this.updatedAt;
  //   data['__v'] = this.iV;
  //   data['LikeCount'] = this.likeCount;
  //   data['username'] = this.username;
  //   data['isLike'] = this.isLike;
  //   return data;
  // }

}

class Comments {
  String? userId;
  String? text;
 // List<Null>? reactions;
  String? timestamp;
  String? sId;
  List<Comments>? comments;

  Comments({this.userId, this.text,
 //  this.reactions,
    this.timestamp, this.sId, this.comments});

  Comments.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    text = json['text'];
    // if (json['reactions'] != null) {
    //   reactions = <Null>[];
    //   json['reactions'].forEach((v) {
    //     reactions!.add(new Null.fromJson(v));
    //   });
    // }
    timestamp = json['timestamp'];
    sId = json['_id'];
    if (json['Comments'] != null) {
      comments = <Comments>[];
      json['Comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['userId'] = this.userId;
  //   data['text'] = this.text;
  //   if (this.reactions != null) {
  //     data['reactions'] = this.reactions!.map((v) => v.toJson()).toList();
  //   }
  //   data['timestamp'] = this.timestamp;
  //   data['_id'] = this.sId;
  //   if (this.comments != null) {
  //     data['Comments'] = this.comments!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

}

// class Comments {
//   String? userId;
//   String? text;
//   String? timestamp;
//   String? sId;

//   Comments({this.userId, this.text, this.timestamp, this.sId});

//   Comments.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     text = json['text'];
//     timestamp = json['timestamp'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['text'] = this.text;
//     data['timestamp'] = this.timestamp;
//     data['_id'] = this.sId;
//     return data;
//   }
// }
