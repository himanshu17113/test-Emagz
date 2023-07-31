class ApiEndpoint {
  // static String ip = " 192.168.43.77";
  static String ip = "192.168.43.100";

  // static String baseUrl = "http://$ip:3000/api";

  // open dev address

  // static String baseUrl =
  //     "http://ec2-15-206-157-157.ap-south-1.compute.amazonaws.com:3000/api";

  // static String baseUrl = "http://ec2-13-233-123-161.ap-south-1.compute.amazonaws.com:3000/api";
     static String baseUrl = "http://ec2-13-233-123-161.ap-south-1.compute.amazonaws.com:3000/api";
  static String socketUrl = "http://$ip:8900";

  static String userInfo(String userId) => "$baseUrl/auth/get-user-details/$userId";

  static String register = "$baseUrl/auth/register";
  static String login = "$baseUrl/auth/login";
  static String sendOtp = "$baseUrl/auth/otp";
  static String verifyOtp = "$baseUrl/auth/verify-otp";
  static String changePassword = "$baseUrl/auth/changepassword";

  static String accountType(String id) => "$baseUrl/auth/profile/$id";
  static String setupPeronalAccount = "$baseUrl/auth/setup-personal-account";
  static String setupProfessionalAccount = "$baseUrl/auth/setup-professional-account";

  static String chooseIntrest = "$baseUrl/auth/addInterest/";
  static String uniqueName(String userId) => "$baseUrl/auth/profile/get-unique-name/$userId";

  static String requestList = "$baseUrl/chat_setting/requests";
  static String blockUser = "$baseUrl/chat_setting/block";

  static String story = "$baseUrl/story/stories";
  static String likeStroy(String storyId) => "$baseUrl/story/$storyId/like";
  static String commentStroy(String storyId) => "$baseUrl/story/comment/${storyId}";
  static String addStory = "$baseUrl/story/";

  static String posts(int skip) {
    return "$baseUrl/post/following/?skip=$skip&limit=10";
  }
  // static String posts = "$baseUrl/post/following/";

  static String likePost(String postId) => "$baseUrl/post/$postId/likeANDunlike";
  static String commentPost(String postId) => "$baseUrl/post/$postId/comment";
  static String doPoll(String postId) => "$baseUrl/post/$postId/Poll";
  static String makePost = "$baseUrl/post";

  //chats

  static String getConversation(String userId) => "$baseUrl/conversations/$userId";
  static String getMessages(String conversationId) => "$baseUrl/messages/$conversationId";
  static String postMessage = "$baseUrl/messages";
}
