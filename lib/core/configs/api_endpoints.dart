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
  static const changePassword = "user/profile/password/update";

  //Category
  static const getCategory = "categories";
  static const getSubCategory = "sidebar/sub-category-counts";
  static getFieldSubCategory(int categoryId) => "sidebar/get-field-by-sub-category/$categoryId";


  //Products
  static const productList = "products";
  static productDetails(String productSlug) => "products/$productSlug";
  static relatedProducts(String productId) => "products/related/$productId";

  //Ads
  static const adsPost = "ads/store";

  //Address
  static const getAllAddresses = "user/address/list";
  static const addAddress = "user/address/store";
  static updateAddress(int addressId) => "user/address/update$addressId";
  static deleteAddress(int addressId) => "user/address/delete$addressId";
  static setDefaultAddress(int addressId) => "user/address/$addressId/set-default";

  // Order endpoints
  static const String orderList = 'user/order/list';
  static String orderDetails(String orderId) => 'user/order/details?order_id=$orderId';
  static String orderCancel(String orderId) => 'user/order/cancel?order_id=$orderId';
  static const String createOrder = 'user/order/initiat';
}
