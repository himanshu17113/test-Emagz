import 'package:hive/hive.dart';
import 'post_model.dart';
part 'user_schema.g.dart';

@HiveType(typeId: 0)
class UserSchema {
  ComentPrivacy? cmnt_priv;
  PostPrivacy? post_priv;
  PostPrivacy? mess_priv;
  PostPrivacy? live_priv;
  PostPrivacy? ment_priv;
  @HiveField(5)
  String? ProfilePic;

  @HiveField(6)
  String? mobileNumber;

  @HiveField(7)
  String? loginOtp;

  @HiveField(8)
  String? personalTemplate;

  @HiveField(9)
  String? sId;

  @HiveField(10)
  String? username;

  @HiveField(11)
  String? email;

  @HiveField(12)
  String? dob;

  @HiveField(13)
  String? accountType;

  @HiveField(14)
  List<String?>? interestName;

  @HiveField(15)
  int? followers;

  @HiveField(16)
  int? followings;

  @HiveField(17)
  String? hirable;

  @HiveField(18)
  int? rating;

  @HiveField(19)
  String? reviews;

  @HiveField(20)
  String? poll;

  @HiveField(21)
  String? jobcreated;

  @HiveField(22)
  String? accountStatus;

  @HiveField(23)
  List<String?>? search;

  @HiveField(24)
  String? createdAt;

  @HiveField(25)
  String? updatedAt;

  @HiveField(26)
  String? getstatedName;

  @HiveField(27)
  String? displayName;


  UserSchema(
      {this.cmnt_priv,
      this.post_priv,
      this.ment_priv,
      this.live_priv,
      this.mess_priv,
      this.mobileNumber,
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
      //  this.iV,
      this.getstatedName,
      this.ProfilePic,
      this.displayName});

  UserSchema.fromJson(Map<String, dynamic> json) {
    post_priv = json['post_privacy'] == null ? null : PostPrivacy.fromJson(json['post_privacy']);
    cmnt_priv = json['comment_privacy'] == null ? null : ComentPrivacy.fromJson(json['comment_privacy']);
    live_priv = json['live_privacy'] == null ? null : PostPrivacy.fromJson(json['live_privacy']);
    ment_priv = json['mention_privacy'] == null ? null : PostPrivacy.fromJson(json['mention_privacy']);
    mess_priv = json['message_privacy'] == null ? null : PostPrivacy.fromJson(json['message_privacy']);

    ProfilePic = json["ProfilePic"];
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
    //  iV = json['__v'];
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
    // data['__v'] = iV;
    data['GetstatedName'] = getstatedName;
    data['displayName'] = displayName;
    return data;
  }
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
