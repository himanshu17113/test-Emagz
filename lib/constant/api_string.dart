class ApiEndpoint {
  // static String ip = " 192.168.43.77";
  static String ip = "192.168.43.100";

  // static String baseUrl = "http://$ip:3000/api";

  // open dev address

  // static String baseUrl =
  //     "http://ec2-15-206-157-157.ap-south-1.compute.amazonaws.com:3000/api";

  // static String baseUrl = "http://ec2-13-233-123-161.ap-south-1.compute.amazonaws.com:3000/api";
  static String baseUrl = "http://ec2-13-233-123-161.ap-south-1.compute.amazonaws.com:3000/api";
  static String socketUrl = "http://ec2-13-233-123-161.ap-south-1.compute.amazonaws.com:3000/socket_connection";

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

  static String story = "$baseUrl/story/stories";
  static String template="$baseUrl/persona/template";
  static String uploadProfilePic="$baseUrl/auth/upload-profile-picture";
  static String userTemplate="$baseUrl/persona/user-template";
  static String likeStroy(String storyId) => "$baseUrl/story/$storyId/like";

  static String commentStroy(String storyId) => "$baseUrl/story/comment/$storyId";
  static String Storybyid(String storyId) => "$baseUrl/story/mystory/$storyId";

  static String addStory = "$baseUrl/story/";

  static String posts(int skip) {
    return "$baseUrl/post/following/?skip=$skip&limit=10";
  }
  // static String posts = "$baseUrl/post/following/";

  static String likePost(String postId) => "$baseUrl/post/$postId/likeANDunlike";
  static String commentPost(String postId) => "$baseUrl/post/$postId/comment";
    static String getcomment(String postId) => "$baseUrl/post/$postId/getcomments";
  
  static String replyPost(String postId, String commentId, String userId) =>
      "$baseUrl/post/comment-on-comment?postId=$postId&commentId=$commentId&userId=$userId";
        static String replyStory(String postId, String commentId, String userId) =>
      "$baseUrl/story/comment?storyId=$postId&commentId=$commentId&userId=$userId";
  static String doPoll(String postId) => "$baseUrl/post/$postId/Poll";
  static String makePost = "$baseUrl/post/";

  //chats

  static String getConversation(String userId) => "$baseUrl/conversations/$userId";
  static String getMessages(String conversationId) => "$baseUrl/messages/$conversationId";

  static String blockUser = "$baseUrl/chat_setting/block";
  static String requestList = "$baseUrl/chat_setting/requests";
  static String acceptRequest(String userId) => "$baseUrl/chat_setting/requests/$userId/accept";
  static String strikeFirstCon = "$baseUrl/conversations/";
  static String getConID(String userId, String secUserId) => "$baseUrl/conversations/find/$userId/$secUserId";

  static String postMessage = "$baseUrl/messages";
  static String postPrivacy= "$baseUrl/auth/change-post-privacy";
  static String commentprivacy= "$baseUrl/auth/change-comment-privacy";
}
