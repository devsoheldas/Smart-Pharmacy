import 'package:dio/dio.dart';
import '../models/product_models.dart';
import '../utils/urls.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<Products?> getProducts() async {
    try {
      final response = await _dio.get(Urls.productUrl);
      if (response.statusCode == 200) {
        return Products.fromJson(response.data);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}