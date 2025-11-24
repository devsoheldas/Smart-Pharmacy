import 'package:dio/dio.dart';
import 'package:e_pharma/core/configs/api_config.dart';
import 'package:e_pharma/core/configs/api_endpoints.dart';
import 'package:e_pharma/core/models/log_in_response_model.dart';
import 'package:e_pharma/core/models/product_models.dart';
import 'package:e_pharma/core/services/shared_preference_service.dart';
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
}
