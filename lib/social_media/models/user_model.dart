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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personalTemplate'] = personalTemplate;
    data['_id'] = sId;
    data['username'] = username;
    data['email'] = email;
    data['dob'] = dob;
    data['password'] = password;
    data['mobile_number'] = mobileNumber;
    data['login_otp'] = loginOtp;
    data['accountType'] = accountType;
    data['interestName'] = interestName;
    data['displayName'] = displayName;
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
    data['businessName'] = businessName;
    data['businessType'] = businessType;
    data['businessLogo'] = businessLogo;
    return data;
  }
}