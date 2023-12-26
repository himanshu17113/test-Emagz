import 'package:hive/hive.dart';
part 'user_schema.g.dart';

@HiveType(typeId: 0)
class UserSchema {
  @HiveField(5)
  String? profilePic;

  @HiveField(6)
  String? mobileNumber;

  @HiveField(7)
  final String? loginOtp;

  @HiveField(8)
  final String? personalTemplate;

  @HiveField(9)
  final String? sId;

  @HiveField(10)
  String? username;

  @HiveField(11)
  String? email;

  @HiveField(12)
  String? dob;

  @HiveField(13)
  final String? accountType;

  @HiveField(14)
  final List<String?>? interestName;

  @HiveField(15)
  final int? followers;

  @HiveField(16)
  final int? followings;

  @HiveField(17)
  final String? hirable;

  @HiveField(18)
  final int? rating;

  @HiveField(19)
  final String? reviews;

  @HiveField(20)
  final String? poll;

  @HiveField(21)
  final String? jobcreated;

  @HiveField(22)
  final String? accountStatus;

  @HiveField(23)
  final List<String?>? search;

  @HiveField(24)
  final String? createdAt;

  @HiveField(25)
  final String? updatedAt;

  @HiveField(26)
  final String? getstatedName;

  @HiveField(27)
  final String? displayName;

  @HiveField(28)
  final bool? enableLocation;

  @HiveField(29)
  final bool? notificationSound;

  @HiveField(30)
  final bool? desktopNotification;

  @HiveField(31)
  final Address? address;

  @HiveField(32)
  final CommentPrivacy? commentPrivacy;

  @HiveField(33)
  final Privacy? postPrivacy;

  @HiveField(34)
  final Privacy? mentionPrivacy;

  @HiveField(35)
  final Privacy? messagePrivacy;

  @HiveField(36)
  final Privacy? livePrivacy;

  @HiveField(37)
  final StoryPrivacy? storyPrivacy;

  @HiveField(38)
  final String? password;

  @HiveField(39)
  final bool? isActive;

  @HiveField(40)
  String? isPrivate;

  @HiveField(41)
  final List<String>? blockUsers;

  @HiveField(42)
  final String? socialType;

  @HiveField(43)
  final String? bio;

  @HiveField(44)
  List<String>? followingData;

  @HiveField(45)
  List<String>? followersData;
  // List<dynamic>? storySpecific;

  UserSchema(
      {this.address,
      this.commentPrivacy,
      this.postPrivacy,
      this.mentionPrivacy,
      this.messagePrivacy,
      this.livePrivacy,
      this.storyPrivacy,
      this.password,
      this.mobileNumber,
      this.isActive,
      this.isPrivate,
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
      this.getstatedName,
      this.profilePic,
      this.displayName,
      this.enableLocation,
      this.notificationSound,
      this.desktopNotification,
      this.blockUsers,
      this.socialType,
      this.bio,
      this.followersData,
      this.followingData});

  factory UserSchema.fromJson(Map<String, dynamic> json) => UserSchema(
        address:
            json["address"] != null ? Address.fromJson(json["address"]) : null,
        commentPrivacy: json["comment_privacy"] != null
            ? CommentPrivacy.fromJson(json["comment_privacy"])
            : null,
        postPrivacy: json["post_privacy"] != null
            ? Privacy.fromJson(json["post_privacy"])
            : null,
        mentionPrivacy: json["mention_privacy"] != null
            ? Privacy.fromJson(json["mention_privacy"])
            : null,
        messagePrivacy: json["mention_privacy"] != null
            ? Privacy.fromJson(json["mention_privacy"])
            : null,
        livePrivacy: json["mention_privacy"] != null
            ? Privacy.fromJson(json["mention_privacy"])
            : null,
        storyPrivacy: json["story_privacy"] != null
            ? StoryPrivacy.fromJson(json["story_privacy"])
            : null,
        sId: json["_id"],
        username: json["username"],
        email: json["email"],
        dob: json["dob"],
        password: json["password"],
        mobileNumber: json["mobile_number"],
        isActive: json["is_active"],
        isPrivate: json["is_private"],
        accountType: json["accountType"],
        interestName: List<String>.from(json["interestName"].map((x) => x)),
        followers: json["Followers"],
        followings: json["Followings"],
        hirable: json["Hirable"],
        rating: json["Rating"],
        reviews: json["Reviews"],
        poll: json["Poll"],
        jobcreated: json["Jobcreated"],
        accountStatus: json["AccountStatus"],
        enableLocation: json["enable_location"],
        notificationSound: json["notification_sound"],
        desktopNotification: json["desktop_notification"],
        blockUsers: List<String>.from(json["blockUsers"].map((x) => x)),
        profilePic: json["ProfilePic"],
        search: List<String?>.from(json["search"].map((x) => x)),
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
        loginOtp: json["login_otp"],
        getstatedName: json["GetstatedName"],
        displayName: json["displayName"],
        //  postCount: json["postCount"],
        personalTemplate: json["personalTemplate"],
        // message: json["message"],
        // reason: json["reason"],
        followingData: List<String>.from(json["followingData"].map((x) => x)),
        followersData: List<String>.from(json["followersData"].map((x) => x)),
        // storySpecific: List<dynamic>.from(json["storySpecific"].map((x) => x)),
        socialType: json["social_type"],
        bio: json["bio"],
        // ratings:
        //     List<Rating>.from(json["Ratings"].map((x) => Rating.fromJson(x))),
      );

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
    // data['__v'] = iV;
    data['GetstatedName'] = getstatedName;
    data['displayName'] = displayName;
    return data;
  }
}

@HiveType(typeId: 1)
class Address {
  @HiveField(0)
  String? addressLine1;
  @HiveField(1)
  String? addressLine2;
  @HiveField(2)
  String? city;
  @HiveField(3)
  String? district;
  @HiveField(4)
  String? pinCode;
  @HiveField(5)
  String? state;
  @HiveField(6)
  String? latitude;
  @HiveField(7)
  String? longitude;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.district,
    this.pinCode,
    this.state,
    this.latitude,
    this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        district: json["district"],
        pinCode: json["pinCode"],
        state: json["state"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "district": district,
        "pinCode": pinCode,
        "state": state,
        "latitude": latitude,
        "longitude": longitude,
      };
}

@HiveType(typeId: 2)
class CommentPrivacy {
  @HiveField(0)
  final bool? everyone;
  @HiveField(1)
  final bool? followers;
  @HiveField(2)
  final bool? follow;
  @HiveField(3)
  final bool? followAndFollowers;

  CommentPrivacy({
    this.everyone,
    this.followers,
    this.follow,
    this.followAndFollowers,
  });

  factory CommentPrivacy.fromJson(Map<String, dynamic> json) => CommentPrivacy(
        everyone: json["everyone"],
        followers: json["followers"],
        follow: json["follow"],
        followAndFollowers: json["follow_and_followers"],
      );

  Map<String, dynamic> toJson() => {
        "everyone": everyone,
        "followers": followers,
        "follow": follow,
        "follow_and_followers": followAndFollowers,
      };
}

@HiveType(typeId: 3)
class Privacy {
  @HiveField(0)
  final bool? everyone;
  @HiveField(1)
  final bool? followers;
  @HiveField(2)
  final bool? noOne;

  Privacy({
    this.everyone,
    this.followers,
    this.noOne,
  });

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
        everyone: json["everyone"],
        followers: json["followers"],
        noOne: json["no_one"],
      );

  Map<String, dynamic> toJson() => {
        "everyone": everyone,
        "followers": followers,
        "no_one": noOne,
      };
}

// @HiveType(typeId: 4)
// class Rating {
//    @HiveField(0)
//   String? userId;
//    @HiveField(1)
//   int? rating;
//    @HiveField(2)
//   String? id;

//   Rating({
//     this.userId,
//     this.rating,
//     this.id,
//   });

//   factory Rating.fromJson(Map<String, dynamic> json) => Rating(
//         userId: json["user_id"],
//         rating: json["rating"],
//         id: json["_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_id": userId,
//         "rating": rating,
//         "_id": id,
//       };
// }

@HiveType(typeId: 5)
class StoryPrivacy {
  @HiveField(0)
  final bool? everyone;
  @HiveField(1)
  final bool? closeFriend;
  @HiveField(2)
  final bool? specific;
  @HiveField(3)
  final bool? noOne;

  StoryPrivacy({
    this.everyone,
    this.closeFriend,
    this.specific,
    this.noOne,
  });

  factory StoryPrivacy.fromJson(Map<String, dynamic> json) => StoryPrivacy(
        everyone: json["everyone"],
        closeFriend: json["close_friend"],
        specific: json["specific"],
        noOne: json["no_one"],
      );

  Map<String, dynamic> toJson() => {
        "everyone": everyone,
        "close_friend": closeFriend,
        "specific": specific,
        "no_one": noOne,
      };
}

























// class User {
//   String? personalTemplate;
//   String? sId;
//   String? username;
//   String? email;
//   String? dob;
//   String? password;
//   String? mobileNumber;
//   String? loginOtp;
//   String? accountType;
//   List<String>? interestName;
//   String? displayName;
//   int? followers;
//   int? followings;
//   String? hirable;
//   String? rating;
//   String? reviews;
//   String? poll;
//   String? jobcreated;
//   String? accountStatus;
//   List<String>? search;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   String? getstatedName;
//   String? businessName;
//   String? businessType;
//   String? businessLogo;

//   User(
//       {this.personalTemplate,
//         this.sId,
//         this.username,
//         this.email,
//         this.dob,
//         this.password,
//         this.mobileNumber,
//         this.loginOtp,
//         this.accountType,
//         this.interestName,
//         this.displayName,
//         this.followers,
//         this.followings,
//         this.hirable,
//         this.rating,
//         this.reviews,
//         this.poll,
//         this.jobcreated,
//         this.accountStatus,
//         this.search,
//         this.createdAt,
//         this.updatedAt,
//         this.iV,
//         this.getstatedName,
//         this.businessName,
//         this.businessType,
//         this.businessLogo});

//   User.fromJson(Map<String, dynamic> json) {
//     personalTemplate = json['personalTemplate'];
//     sId = json['_id'];
//     username = json['username'];
//     email = json['email'];
//     dob = json['dob'];
//     password = json['password'];
//     mobileNumber = json['mobile_number'];
//     loginOtp = json['login_otp'];
//     accountType = json['accountType'];
//     interestName = json['interestName'].cast<String>();
//     displayName = json['displayName'];
//     followers = json['Followers'];
//     followings = json['Followings'];
//     hirable = json['Hirable'];
//     rating = json['Rating'];
//     reviews = json['Reviews'];
//     poll = json['Poll'];
//     jobcreated = json['Jobcreated'];
//     accountStatus = json['AccountStatus'];
//     search = json['search'].cast<String>();
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     getstatedName = json['GetstatedName'];
//     businessName = json['businessName'];
//     businessType = json['businessType'];
//     businessLogo = json['businessLogo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['personalTemplate'] = personalTemplate;
//     data['_id'] = sId;
//     data['username'] = username;
//     data['email'] = email;
//     data['dob'] = dob;
//     data['password'] = password;
//     data['mobile_number'] = mobileNumber;
//     data['login_otp'] = loginOtp;
//     data['accountType'] = accountType;
//     data['interestName'] = interestName;
//     data['displayName'] = displayName;
//     data['Followers'] = followers;
//     data['Followings'] = followings;
//     data['Hirable'] = hirable;
//     data['Rating'] = rating;
//     data['Reviews'] = reviews;
//     data['Poll'] = poll;
//     data['Jobcreated'] = jobcreated;
//     data['AccountStatus'] = accountStatus;
//     data['search'] = search;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     data['GetstatedName'] = getstatedName;
//     data['businessName'] = businessName;
//     data['businessType'] = businessType;
//     data['businessLogo'] = businessLogo;
//     return data;
//   }
// }
