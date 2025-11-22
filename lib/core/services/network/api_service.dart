import 'package:dio/dio.dart';
import 'package:e_pharma/core/configs/api_config.dart';
import 'package:e_pharma/core/configs/api_endpoints.dart';
import 'package:e_pharma/core/models/log_in_response_model.dart';
import 'package:e_pharma/core/services/shared_preference_service.dart';

import 'api_response.dart';

class ApiService{
  late final Dio dio;
  ApiService(){
    dio = Dio(BaseOptions(
      baseUrl: ApiConfig.BASE_URL,
      connectTimeout:const Duration(seconds: 30),
      receiveTimeout:const Duration(seconds: 30)
    ));

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      )
    );
  }

  Future<ApiResponse<LogInResponseModel>> logInUser(String phone, String password) async{

    try {
      final response = await dio.post(
          ApiEndpoints.login,
          data: {
            'phone': phone,
            'password': password,
          }
      );

      if(response.statusCode == 200){
        final logInResponse = LogInResponseModel.fromJson(response.data);

        if(logInResponse.token?.isNotEmpty ?? false){
          SharedPrefService.saveToken(logInResponse.token);
        }

        return ApiResponse.success(logInResponse,message: logInResponse.message ?? "Login Success");
      }else{
        final logInResponse = LogInResponseModel.fromJson(response.data);
        return ApiResponse.error(logInResponse.message ?? "Login Failed");
      }

    }on DioException catch(e){
      return ApiResponse.error(e.response?.data?["message"] ?? "Login Failed");
    }catch(e){
      return ApiResponse.error(e.toString());
    }
  }

}