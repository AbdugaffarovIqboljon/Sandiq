import 'package:dio/dio.dart';
import 'package:sandiq/services/user_service/token_manager.dart';

class Product {
  final int id;
  final String name;
  final int amount;
  final String size;
  final double? price;

  Product({
    required this.id,
    required this.name,
    required this.amount,
    required this.size,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      amount: json['amount'] ?? 0,
      size: json['size'] ?? '',
      price: json['price'] != null ? json['price'].toDouble() : null,
    );
  }
}

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    String? token = await TokenManager.getToken();

    if (token == null) {
      throw Exception('Token is missing');
    }

    try {
      final response = await _dio.get(
        'https://e-work-backend-production.up.railway.app/products/list',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data ?? [];
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        print('Failed to fetch products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }


  Future<void> editProduct({
    required int productId,
    required int amount,
    required String description,
    required String deliveryName,
    required String deliveryPhone,
    required bool status,
  }) async {
    try {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is missing');
      }

      Map<String, dynamic> requestBody = {
        "products": [
          {
            "product_id": productId,
            "amount": amount,
            "description": description,
          }
        ],
        "delivery": {
          "name": deliveryName,
          "phone": deliveryPhone,
        },
        "status": status
      };

      Response response = await _dio.post(
        'https://e-work-backend-production.up.railway.app/products/sadmin/edit',
        data: requestBody,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request successful');
        return response.data;
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}
