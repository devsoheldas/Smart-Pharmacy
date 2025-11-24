import 'package:dio/dio.dart';
import 'package:e_pharma/core/configs/api_config.dart';
import 'package:e_pharma/core/configs/api_endpoints.dart';
import 'package:e_pharma/core/models/log_in_response_model.dart';
import 'package:e_pharma/core/services/shared_preference_service.dart';

import '../../models/profile_models/profile_details_screen_model.dart';
import '../../models/sing_up_response_model.dart';
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
      final errorMsg = e.response?.data?["message"] ?? "Registration failed network error";
      return ApiResponse.error(errorMsg);
    } catch (e) {

      return ApiResponse.error("error: ${e.toString()}");
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
        final profileResponse = ProfileDetailsScreenModel.fromJson(response.data);
        return ApiResponse.success(
          profileResponse,
          message: profileResponse.message ?? "Profile updated successfully",
        );
      } else {
        final errorMsg = response.data?["message"] ?? "Failed to update profile";
        return ApiResponse.error(errorMsg);
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data?["message"] ?? "Network error";
      return ApiResponse.error(errorMsg);
    } catch (e) {
      return ApiResponse.error("Error: ${e.toString()}");
    }
  }
}



