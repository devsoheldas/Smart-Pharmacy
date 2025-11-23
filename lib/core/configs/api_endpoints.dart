class ApiEndpoints {

  //Auth
  static const login = "user/authentication/password-login";
  static const logout = "auth/logout";
  static const forgotPassword = "forget-password";
  static const forgotPasswordSubmit = "change-password";
  static const register = "user/authentication/registration";
  static const passwordUpdate = "user/password/update";
  static const fcmTokenUpdate = "user/fcm_token/update";
  static const otpVerify = "otp-verify";
  static const resendVerificationCode = "user/registration/resend_verification_code";

  //User
  static const userDetails = "user/profile/info";
  static const updateProfile = "user/profile/update";

  //Category
  static const getCategory = "sidebar/category-counts";
  static const getSubCategory = "sidebar/sub-category-counts";
  static getFieldSubCategory(int categoryId) => "sidebar/get-field-by-sub-category/$categoryId";


  //Products
  static const productList = "products/list";
  static productDetails(String productSlug) => "products/$productSlug";
  static relatedProducts(String productId) => "products/related/$productId";

  //Ads
  static const adsPost = "ads/store";





}
