import 'package:dio/dio.dart';
import 'package:task/features/data/models/product_model.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
class ProductRepository {
  final Dio dio;

  ProductRepository(this.dio) {
    dio.options = BaseOptions(
      baseUrl: 'https://stg.koueider.com/wp-json/apis/v2/',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      validateStatus: (status) => status! < 500,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    );

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
    }
  }

  Future<List<ProductModel>> getProducts({
    required int page,
    String? category,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final response = await dio.get(
        'products/filter',
        queryParameters: {
          'page': page,
          if (category != null) 'category': category,
          'products_per_page': 3,
          if (sortBy != null) 'sort[criteria]': sortBy,
          if (sortOrder != null) 'sort[arrangement]': sortOrder,
        },
      );

      if (response.statusCode == 200) {
        final productsData = response.data;
        if (productsData != null && productsData['products'] is List) {
          return (productsData['products'] as List)
              .map((json) => ProductModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}