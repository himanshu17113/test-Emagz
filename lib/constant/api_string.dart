class ApiEndpoint {
  // static String ip = " 192.168.43.77";
  static String ip = "192.168.43.100";

  static String baseUrl = "https://www.emagz.live/api";
  // "https://emagztesting.emagz.live/api";

  static String socketUrl = "https://emagz.live/socket_connection";
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
  static String template = "$baseUrl/persona/template";
  static String uploadProfilePic = "$baseUrl/auth/upload-profile-picture";
  static String userTemplate = "$baseUrl/persona/user-template";
  //  static String getTemplateID = "$baseUrl/persona/user-template/";
  static String likeStroy(String storyId) => "$baseUrl/story/$storyId/like";

  static String commentStroy(String storyId) => "$baseUrl/story/comment/$storyId";
  static String Storybyid(String storyId) => "$baseUrl/story/mystory/$storyId";
  static String removeSingleNotification(String notificationId) => "$baseUrl/notification/remove/$notificationId";
  static String clearAllNotification(String userID) => "$baseUrl/notification/clearAll/$userID";
  static String addStory = "$baseUrl/story/";

  static String posts(int skip) {
    return "$baseUrl/post/following/?skip=$skip&limit=10";
  }
  // static String posts = "$baseUrl/post/following/";

  static String likePost(String postId) => "$baseUrl/post/$postId/likeANDunlike";
  static String commentPost(String postId) => "$baseUrl/post/$postId/comment";
  static String getcomment(String postId) => "$baseUrl/post/$postId/getcomments";

  static String replyPost(
    String postId,
    String commentId,
    String userId,
    String? replyCommentId,
  ) =>
      "$baseUrl/post/comment-on-comment?postId=$postId&commentId=$commentId&userId=$userId${(replyCommentId != null && replyCommentId.isNotEmpty) ? "&replyCommentId=$replyCommentId" : ""}";
  static String replyStory(String postId, String commentId, String userId) =>
      "$baseUrl/story/comment?storyId=$postId&commentId=$commentId&userId=$userId";
  static String doPoll(String postId) => "$baseUrl/post/$postId/Poll";
  static String pollResults(String postId) => "$baseUrl/post/$postId/PollResults";

  static String makePost = "$baseUrl/post/";

  //chats

  static String getConversation(String userId) => "$baseUrl/conversations/$userId";
  static String getMessages(String conversationId) => "$baseUrl/messages/$conversationId";

  static String blockUser = "$baseUrl/chat_setting/block";
  static String requestList = "$baseUrl/chat_setting/requests";
  static String removeRequest = "$baseUrl/chat_setting/removeRequest";
  static String acceptRequest(String userId) => "$baseUrl/chat_setting/requests/$userId/accept";
  static String strikeFirstCon = "$baseUrl/conversations/";
  static String getConID(String userId, String secUserId) => "$baseUrl/conversations/find/$userId/$secUserId";

  static String postMessage = "$baseUrl/messages";
  static String messagePrivacy = "$baseUrl/auth/change-message-privacy";

  static String livePrivacy = "$baseUrl/auth/change-live-privacy";
  static String storyPrivacy = "$baseUrl/auth/change-story-privacy";
  static String mentionPrivacy = "$baseUrl/auth/change-mention-privacy";

  static String postPrivacy = "$baseUrl/auth/change-post-privacy";

  static String commentprivacy = "$baseUrl/auth/change-comment-privacy";
  static String getAllSupport = "$baseUrl/support/get";
  static String getSupportById = "$baseUrl/support/getById";
  static String createSupport = "$baseUrl/support/create";
  static String updateUserDetails = "$baseUrl/auth/update-user-details";
  static String updateUserbio = "$baseUrl/auth/update-user-bio";

  static String createTicket = "$baseUrl/ticket/create";
  static String getTicketbyUserId(String userId) => "$baseUrl/ticket/get/$userId";

  static String makeAccountPrivate(bool makePrivate) => "$baseUrl/auth/make-account-private?status=${makePrivate ? "Yes" : "No"}";
}
