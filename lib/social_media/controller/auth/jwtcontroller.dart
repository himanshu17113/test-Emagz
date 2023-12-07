// import 'package:dio/dio.dart';
// import 'package:emagz_vendor/constant/api_string.dart';
// import 'package:emagz_vendor/constant/data.dart';
// import 'package:emagz_vendor/social_media/models/post_model.dart';
// import 'package:flutter/cupertino.dart';
 

// class JWTController {
 
//   UserSchema? currentUser;
//   UserSchema? user = UserSchema();
 
//   JWTController() {
    
//     debugPrint(globToken);
//     debugPrint(globUserId);
    
//   }

 
//   Future<UserSchema?> getUserDetail(String id) async {
//     try {
//       Dio dio = Dio();
//       var userToken = await getAuthToken();
//       dio.options.headers["Authorization"] = userToken ??
//           "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGMyMzBmMGZiNGRhNjZmNDBlZDdkNzEiLCJpYXQiOjE2OTA0NDgxMTJ9.EJ8G32sWR2ZqHg7LJ-IHppNGPVwU3-wn5lN5uFo6DvQ";

//       var response = await dio.get(ApiEndpoint.userInfo(id));
//       //  debugPrint(response.data);
//       var userDetails = UserSchema.fromJson(response.data);
//       currentUser ??= userDetails;
//       return userDetails;
//     } catch (e) {
//       debugPrint("get Id Error HImanshu");
//       return null;
//     }
//   }

  
 

//   Future setProfileImage(String imageUrl) async {
//     await hiveBox.put('ProfilePic', imageUrl);
//     profilePic.value = imageUrl;
//   }

//   Future<String> getProfileImage() async {
//     var imageUrl = await hiveBox.get('ProfilePic');
//     if (imageUrl != null) {
//       globProfilePic = imageUrl;
//       profilePic.value = imageUrl!;
//     }

//     return imageUrl;
//   }
// }
