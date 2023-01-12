class ApiConstants {
  // Api.
  static const String baseUrl = "http://freeserver23-001-site1.atempurl.com/api";
  static const String auth = "Auth";

  // End points | Paths.
  // Login pharmacy screen
  static const String login = "$baseUrl/$auth/Login";
  static const String register = "$baseUrl/$auth/register";

  // Forget password screen
  static const String forgetPassword = "$baseUrl/$auth/Forgetpassword";

  static String forgetPasswordEmailPath(String email) =>
      "$forgetPassword/$email";

  static const String sendMail = "$baseUrl/$auth/SendMail";

  // Activate email screen
  static const String activation = "$baseUrl/$auth/Activation";

  static String activationCodePath(int code) => "$activation/$code";

  // Reset password screen
  static const String resetPassword = "$baseUrl/$auth/ResetPassword";
  static  String resetPasswordByOldPassword(String userId) => "$baseUrl/Users/PutUserPassword/$userId";

  // About us screen
  static const String aboutUs = "$baseUrl/AboutUs";
  static String aboutUsTypePath(String type) => "$aboutUs/$type";
  // Contact us screen
  static const String contactUs = "$aboutUs/GetContactUs";

  // Add medicine screen
  static const String products = "$baseUrl/Products";

  // Pharmacy user profile screen
  static String productIdPath(int productId) => "$products/$productId";
  static const String productsByCategoryAndID =
      "$products/GetPharmacyProductByCategory";

  static String productsByCategoryAndIDPath(int pharmacyId,
      String categoryName) => "$productsByCategoryAndID/$pharmacyId/$categoryName";

  static const String pharmacies = "$baseUrl/Pharmacies";
  static const String userPharmacy = "$pharmacies/UserPharmacy";

  static String UserIdPath(String userId) => "$baseUrl/Users/$userId";

  static const String categories = "$baseUrl/Categories";
  static String getCategoryBySuperCategoryId(int SuperCategoryId) => "$categories/GetCategoryBySuperCatgory/$SuperCategoryId";

  // Complaints screen
  static const String complaints = "$baseUrl/Issues";


  //cart
  static String getCartByUserId(String userId) => "$baseUrl/Carts/$userId";
  static const String postCart = "$baseUrl/Carts";
  static const String postCartProducts = "$postCart/CartProducts";
//order
  static  String followOrder(int orderId) => "$baseUrl/OrderStepper/FollowOrder/$orderId";
  static String getUserOrdersByDeliveryId(String Id) => "$baseUrl/Pharmacies/GetPharmacyOrderByDelivery/$Id";
  static String postOrder(String userId,int orderId)
  => "$baseUrl/OrderStepper/OnAcceptedDeliveryOrder/$userId/$orderId";

  static String getPharmacyByID(int pharmacyId) => "$baseUrl/Pharmacies/GetPharmacy/$pharmacyId";

  static String getNotifications(String userId) => "$baseUrl/Notifications/$userId";



}
