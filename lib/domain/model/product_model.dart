import 'package:dio/dio.dart';
import 'package:sandiq/domain/model/product_delivery.dart';
import 'package:sandiq/domain/model/product_history_model.dart';
import 'package:sandiq/domain/model/raw_materials_model.dart';
import 'package:sandiq/services/user_service/token_manager.dart';

import 'history_model.dart';

class Product {
  late int id;
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          amount == other.amount &&
          size == other.size &&
          price == other.price;

  @override
  int get hashCode => Object.hash(id, name, amount, price, size);

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

  /// #Fetch Products
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

  /// #Post Incoming Product
  Future<void> postIncomingProduct({
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

      Map<String, Object?> requestBody = {
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
            'Content-Type': 'application/json'
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
      print('My Error: $e');
    }
  }

  /// #Post OutGoing Product
  Future<void> postOutGoingProduct({
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

      Map<String, Object?> requestBody = {
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
        'https://e-work-backend-production.up.railway.app/products/sadmin/outgoing',
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
      print('My Error: $e');
    }
  }

  /// #Fetch Product History
  Future<List<ProductHistory>> fetchProductHistory() async {
    String? token = await TokenManager.getToken();

    if (token == null) {
      throw Exception('Token is missing');
    }

    try {
      final response = await _dio.get(
        'https://e-work-backend-production.up.railway.app/products/sadmin/history',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Object?> data = response.data ?? [];
        return data
            .map(
                (json) => ProductHistory.fromJson(json as Map<String, Object?>))
            .toList();
      } else {
        print('Failed to fetch product history: ${response.statusCode}');
        return [];
      }
    } catch (e, l) {
      print('Error fetching product history: $e');
      print('Location of Error fetching product history: $l');
      return [];
    }
  }

  /// #Fetch Incoming Products
  Future<List<DeliveredProduct>> fetchIncomingProducts() async {
    String? token = await TokenManager.getToken();

    if (token == null) {
      throw Exception('Token is missing');
    }

    try {
      final response = await _dio.get(
        'https://e-work-backend-production.up.railway.app/products/get/incoming-products',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data ?? [];
        return data.map((json) => DeliveredProduct.fromJson(json)).toList();
      } else {
        print('Failed to fetch incoming products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching incoming products: $e');
      return [];
    }
  }

  /// #Fetch OutGoing Products

  Future<List<DeliveredProduct>> fetchOutGoingProducts() async {
    String? token = await TokenManager.getToken();

    if (token == null) {
      throw Exception('Token is missing');
    }

    try {
      final response = await _dio.get(
        'https://e-work-backend-production.up.railway.app/products/get/outgoing-products',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data ?? [];
        return data.map((json) => DeliveredProduct.fromJson(json)).toList();
      } else {
        print('Failed to fetch incoming products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching incoming products: $e');
      return [];
    }
  }

  /// #Fetch UserCart

  Future<List<Product>> fetchUserCart() async {
    String? token = await TokenManager.getToken();
    if (token == null) {
      throw Exception('Token is missing');
    }
    try {
      Response response = await _dio.get(
        'https://e-work-backend-production.up.railway.app/products/sadmin/list',
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
        print('Failed to fetch incoming products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching incoming products: $e');
      return [];
    }
  }

  /// #Fetch Histroy Manager Role

  Future<List<History>> fetchHistoryData() async {
    String? token = await TokenManager.getToken();

    if (token == null) {
      throw Exception('Token is missing');
    }

    try {
      final response = await _dio.get(
        'https://e-work-backend-production.up.railway.app/bid/object/history',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data ?? [];
        return data.map((json) => History.fromJson(json)).toList();
      } else {
        print('Failed to fetch history data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching history data: $e');
      return [];
    }
  }

  /// #Fetch Home Data Manager Role
  Future<RawMaterials?> fetchHomeDataManagerRole(int id) async {
    String? token = await TokenManager.getToken();
    try {
      Response response = await _dio.get(
        'https://e-work-backend-production.up.railway.app/products/set/list/$id',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return RawMaterials.fromJson(response.data);
    } catch (e, l) {
      print('Error: $e');
      print('Location: $l');
      return null;
    }
  }


  /// #Post Product in Add Screen Manager
  Future<bool> postDataToBackend(Map<String, Object?> requestBody) async {
    try {
      String? token = await TokenManager.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('Token is missing');
      }

      Response response = await _dio.post(
        'https://e-work-backend-production.up.railway.app/bid/object/create',
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Data posted successfully');
        return true; // Indicate success
      } else {
        print('Failed to post data. Status code: ${response.statusCode}');
        return false; // Indicate failure
      }
    } catch (error) {
      print('Error: $error');
      return false; // Indicate failure
    }
  }

}

final jsonExample = {
  "id": 6,
  "name": "Mix",
  "amount": 10,
  "price": 3800.0,
  "size": "kg",
  "total_price": 38000,
  "status": true,
  "date": "2023-12-11T10:34:33.801545Z",
  "delivery": {
    "id": 6,
    "name": "Xurshidbek",
    "phone": "998933914744",
  },
  "warehouse": {
    "id": 2,
    "name": "Склад 2",
    "address": "Сергильский район",
  }
};
