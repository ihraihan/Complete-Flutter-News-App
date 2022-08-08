class Config {
  static String websiteUrl = "https://techcrunch.com";
  static String apiURL = "$websiteUrl/wp-json/wp/v2/";
  static String categoryURl = "categories";
  static String categoryPostURL = "posts?_embed&categories=";
  static String latestPostsURL = "posts?_embed";
  static String searchPosts = "posts?_embed&search=";

  // OneSignal Push Notification App Id
  static String oneSignalAppId = "";
}
