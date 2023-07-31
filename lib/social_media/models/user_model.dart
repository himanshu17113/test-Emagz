class User {
  String? personalTemplate;
  String? sId;
  String? username;
  String? email;
  String? dob;
  String? password;
  String? mobileNumber;
  String? loginOtp;
  String? accountType;
  List<String>? interestName;
  String? displayName;
  int? followers;
  int? followings;
  String? hirable;
  String? rating;
  String? reviews;
  String? poll;
  String? jobcreated;
  String? accountStatus;
  List<String>? search;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? getstatedName;
  String? businessName;
  String? businessType;
  String? businessLogo;

  User(
      {this.personalTemplate,
        this.sId,
        this.username,
        this.email,
        this.dob,
        this.password,
        this.mobileNumber,
        this.loginOtp,
        this.accountType,
        this.interestName,
        this.displayName,
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
        this.businessName,
        this.businessType,
        this.businessLogo});

  User.fromJson(Map<String, dynamic> json) {
    personalTemplate = json['personalTemplate'];
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    dob = json['dob'];
    password = json['password'];
    mobileNumber = json['mobile_number'];
    loginOtp = json['login_otp'];
    accountType = json['accountType'];
    interestName = json['interestName'].cast<String>();
    displayName = json['displayName'];
    followers = json['Followers'];
    followings = json['Followings'];
    hirable = json['Hirable'];
    rating = json['Rating'];
    reviews = json['Reviews'];
    poll = json['Poll'];
    jobcreated = json['Jobcreated'];
    accountStatus = json['AccountStatus'];
    search = json['search'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    getstatedName = json['GetstatedName'];
    businessName = json['businessName'];
    businessType = json['businessType'];
    businessLogo = json['businessLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalTemplate'] = this.personalTemplate;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['password'] = this.password;
    data['mobile_number'] = this.mobileNumber;
    data['login_otp'] = this.loginOtp;
    data['accountType'] = this.accountType;
    data['interestName'] = this.interestName;
    data['displayName'] = this.displayName;
    data['Followers'] = this.followers;
    data['Followings'] = this.followings;
    data['Hirable'] = this.hirable;
    data['Rating'] = this.rating;
    data['Reviews'] = this.reviews;
    data['Poll'] = this.poll;
    data['Jobcreated'] = this.jobcreated;
    data['AccountStatus'] = this.accountStatus;
    data['search'] = this.search;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['GetstatedName'] = this.getstatedName;
    data['businessName'] = this.businessName;
    data['businessType'] = this.businessType;
    data['businessLogo'] = this.businessLogo;
    return data;
  }
}