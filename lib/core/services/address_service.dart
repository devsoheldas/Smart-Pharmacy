import 'package:dio/dio.dart';
import 'package:e_pharma/core/configs/api_config.dart';
import 'package:e_pharma/core/configs/api_endpoints.dart';
import 'package:e_pharma/core/services/network/api_response.dart';
import 'package:e_pharma/core/services/shared_preference_service.dart';
import '../models/address_response_model.dart';


class AddressService {
  late final Dio dio;

  AddressService() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.BASE_URL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // Add token to all requests
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
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

  // Fetch all addresses
  Future<ApiResponse<List<AddressData>>> getAllAddresses() async {
    try {
      final response = await dio.get(ApiEndpoints.getAllAddresses);

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
      final response = await dio.post(
        ApiEndpoints.addAddress,
        data: addressData,
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
      final response = await dio.post(
        ApiEndpoints.updateAddress(addressId),
        data: addressData,
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
      final response = await dio.delete(ApiEndpoints.deleteAddress(addressId));

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
}