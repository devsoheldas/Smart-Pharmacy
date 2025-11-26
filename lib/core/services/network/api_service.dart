
import 'package:dio/dio.dart';
import 'package:e_pharma/core/configs/api_config.dart';
import 'package:e_pharma/core/configs/api_endpoints.dart';
import 'package:e_pharma/core/models/address_response_model.dart';
import 'package:e_pharma/core/models/log_in_response_model.dart';
import 'package:e_pharma/core/models/product_models.dart';
import 'package:e_pharma/core/models/wishlist_model.dart' hide Product;
import 'package:e_pharma/core/services/shared_preference_service.dart';
import '../../models/profile_models/profile_details_screen_model.dart';
import '../../models/sing_up_response_model.dart';
import '../../models/wishlist_update_model.dart';
import 'api_response.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.BASE_URL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  // Login
  Future<ApiResponse<LogInResponseModel>> logInUser(
    String phone,
    String password,
  ) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: {'phone': phone, 'password': password},
      );

      if (response.statusCode == 200) {
        final logInResponse = LogInResponseModel.fromJson(response.data);

        if (logInResponse.token?.isNotEmpty ?? false) {
          SharedPrefService.saveToken(logInResponse.token);
        }

        return ApiResponse.success(
          logInResponse,
          message: logInResponse.message ?? "Login Success",
        );
      } else {
        final logInResponse = LogInResponseModel.fromJson(response.data);
        return ApiResponse.error(logInResponse.message ?? "Login Failed");
      }
    } on DioException catch (e) {
      return ApiResponse.error(e.response?.data?["message"] ?? "Login Failed");
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  // Signup
  Future<ApiResponse<SingupResponseModel>> singUpUser(
    String phone,
    String password,
    String name,
    String confirmationPassword,
  ) async {
    try {
      final response = await dio.post(
        ApiEndpoints.register,
        data: {
          'name': name,
          'phone': phone,
          'password': password,
          'password_confirmation': confirmationPassword,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signUpResponse = SingupResponseModel.fromJson(response.data);
        return ApiResponse.success(
          signUpResponse,
          message: signUpResponse.message ?? "Registration successful",
        );
      } else {
        final errorMsg = response.data?["message"] ?? "Registration failed";
        return ApiResponse.error(errorMsg);
      }
    } on DioException catch (e) {
      final errorMsg =
          e.response?.data?["message"] ?? "Registration failed network error";
      return ApiResponse.error(errorMsg);
    } catch (e) {
      return ApiResponse.error("error: ${e.toString()}");
    }
  }

  // fetched All Address
  Future<ApiResponse<List<AddressData>>> getAllAddresses() async {
    try {
      final token = await SharedPrefService.getToken();
      if (token == null || token.isEmpty){
        return ApiResponse.error('No Address Found');
      }
      final response = await dio.get(
        ApiEndpoints.getAllAddresses,
        options: Options(
          headers: {
            'Authorization' : 'Bearer $token'
          }
        )
      );

      if (response.statusCode == 200) {
        final addressModel = AddressModel.fromJson(response.data);

        return ApiResponse.success(
          addressModel.data ?? [],
          message: addressModel.message ?? "Addresses fetched successfully",
        );
      } else {
        return ApiResponse.error("Failed to fetch addresses");
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?["message"] ?? "Network error while fetching addresses",
      );
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }

  // Add new address
  Future<ApiResponse<AddressData>> addAddress(Map<String, dynamic> addressData) async {
    try {
      final token = await SharedPrefService.getToken();
      if (token == null || token.isEmpty){
        return ApiResponse.error('No Address Found');
      }
      final response = await dio.get(
          ApiEndpoints.getAllAddresses,
          options: Options(
              headers: {
                'Authorization' : 'Bearer $token'
              }
          )
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final addressModel = AddressModel.fromJson(response.data);

        return ApiResponse.success(
          addressModel.data?.first ?? AddressData(),
          message: addressModel.message ?? "Address added successfully",
        );
      } else {
        return ApiResponse.error("Failed to add address");
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?["message"] ?? "Network error while adding address",
      );
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }

  // Update address
  Future<ApiResponse<AddressData>> updateAddress(int addressId, Map<String, dynamic> addressData) async {
    try {
      final token = await SharedPrefService.getToken();
      if (token == null || token.isEmpty){
        return ApiResponse.error('No Address Found');
      }
      final response = await dio.get(
          ApiEndpoints.getAllAddresses,
          options: Options(
              headers: {
                'Authorization' : 'Bearer $token'
              }
          )
      );

      if (response.statusCode == 200) {
        final addressModel = AddressModel.fromJson(response.data);

        return ApiResponse.success(
          addressModel.data?.first ?? AddressData(),
          message: addressModel.message ?? "Address updated successfully",
        );
      } else {
        return ApiResponse.error("Failed to update address");
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?["message"] ?? "Network error while updating address",
      );
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }

  // Delete address
  Future<ApiResponse<bool>> deleteAddress(int addressId) async {
    try {
      final token = await SharedPrefService.getToken();
      if (token == null || token.isEmpty){
        return ApiResponse.error('No Address Found');
      }
      final response = await dio.get(
          ApiEndpoints.getAllAddresses,
          options: Options(
              headers: {
                'Authorization' : 'Bearer $token'
              }
          )
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return ApiResponse.success(
          true,
          message: response.data?["message"] ?? "Address deleted successfully",
        );
      } else {
        return ApiResponse.error("Failed to delete address");
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?["message"] ?? "Network error while deleting address",
      );
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }

  // Set default address
  Future<ApiResponse<bool>> setDefaultAddress(int addressId) async {
    try {
      final response = await dio.post(ApiEndpoints.setDefaultAddress(addressId));

      if (response.statusCode == 200) {
        return ApiResponse.success(
          true,
          message: response.data?["message"] ?? "Default address updated successfully",
        );
      } else {
        return ApiResponse.error("Failed to set default address");
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?["message"] ?? "Network error while setting default address",
      );
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }

  // Fetch Profile Details
  Future<ApiResponse<ProfileDetailsScreenModel>> getProfileDetails() async {
    try {
      final token = await SharedPrefService.getToken();

      if (token == null || token.isEmpty) {
        return ApiResponse.error("No authentication token found");
      }

      final response = await dio.get(
        ApiEndpoints.userDetails,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final profileResponse = ProfileDetailsScreenModel.fromJson(response.data);
        return ApiResponse.success(
          profileResponse,
          message: profileResponse.message ?? "Profile fetched successfully",
        );
      } else {
        final errorMsg = response.data?["message"] ?? "Failed to fetch profile";
        return ApiResponse.error(errorMsg);
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data?["message"] ?? "Network error";
      return ApiResponse.error(errorMsg);
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }

  // Update Profile
  Future<ApiResponse<ProfileDetailsScreenModel>> updateProfile({
    required String name,
    required String email,
    required String phone,
    String? dob,
    int? gender,
  }) async {
    try {
      final token = await SharedPrefService.getToken();

      if (token == null || token.isEmpty) {
        return ApiResponse.error("No authentication token found");
      }

      final response = await dio.post(
        ApiEndpoints.updateProfile,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          if (dob != null) 'dob': dob,
          if (gender != null) 'gender': gender,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final profileResponse = ProfileDetailsScreenModel.fromJson(
            response.data);
        return ApiResponse.success(
          profileResponse,
          message: profileResponse.message ?? "Profile updated successfully",
        );
      } else {
        final errorMsg = response.data?["message"] ??
            "Failed to update profile";
        return ApiResponse.error(errorMsg);
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data?["message"] ?? "Network error";
      return ApiResponse.error(errorMsg);
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }

  // Get Products
  Future<ApiResponse<Product>> getProducts() async {
    try {
      final response = await dio.get(ApiEndpoints.productList);

      if (response.statusCode == 200) {
        final product = Product.fromJson(response.data);
        return ApiResponse.success(
          product,
          message: "Products loaded successfully",
        );
      } else {
        return ApiResponse.error(
          "Failed to load products: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?["message"] ?? "Failed to load products",
      );
    } catch (e) {
      return ApiResponse.error("Failed to load products: $e");
    }
  }
  


  // categories
  Future<Response> get(String endpoint) async {
    try {
      return await dio.get(endpoint);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  //======= get all wish list ============


  Future<ApiResponse<WishlistModel>> getWishlist() async {
    final token = await SharedPrefService.getToken();

    if (token == null || token.isEmpty) {
      return ApiResponse.error("No authentication token found");
    }

    try {
      final response = await Dio().get(
          ApiEndpoints.wishlistapiendpoint,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final wishlistrespone = WishlistModel.fromJson(response.data);
        return ApiResponse.success(
          wishlistrespone,
          message: wishlistrespone.message ?? "successfully add wishlist",
        );
      } else {
        final errorMsg = response.data?["message"] ??
            "Failed to add wishlist";
        return ApiResponse.error(errorMsg);
      }
    } catch (error) {
      return ApiResponse.error("Error: ${error.toString()}");
    }
  }




  //========add to wish list ========

  Future<ApiResponse<WishlistUpdateModel>> addToWishlist(int productId) async {

    try {
      final response = await Dio().post(
        ApiEndpoints.wishlistapiendpoint,
        data: {'product_id': productId},
      );

      if (response.statusCode == 200) {
          final wishlistrespone = WishlistUpdateModel.fromJson(response.data);
          return ApiResponse.success(
              wishlistrespone,
            message: wishlistrespone.message ?? "successfully add wishlist",
          );

      } else {
        final errorMsg = response.data?["message"] ??
            "Failed to add wishlist";
        return ApiResponse.error(errorMsg);
      }
    } catch (error) {
      return ApiResponse.error("Error: ${error.toString()}");
    }
  }

  // ========= update wish list ========

  Future<ApiResponse<WishlistUpdateModel>> updataToWishList( int productId) async {
    try{
      final respone = await Dio().post(
        ApiEndpoints.updatewishlistapiendpoint,
        data: {
         "product_id" : productId ,
        }
      );
      if(respone.statusCode == 200){
        final wishlistrespone = WishlistUpdateModel.fromJson(respone.data);
        return ApiResponse.success(
          wishlistrespone,
          message: wishlistrespone.message ?? "successfully update wishlist",
        );
      }else{
        final errorMsg = respone.data?["message"] ??
          "Failed to update profile";
        return ApiResponse.error(errorMsg);
      }
    }catch (error){
      return ApiResponse.error("Error: ${error.toString()}");
    }
  }

}



