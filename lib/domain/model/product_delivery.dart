class DeliveryInfo {
  final String name;
  final String phone;

  DeliveryInfo({
    required this.name,
    required this.phone,
  });

  factory DeliveryInfo.fromJson(Map<String, Object?> json) {
    return DeliveryInfo(
      name: json['name'] as String,
      phone: json['phone'] as String,
    );
  }
}

class ProductBaseInfo {
  final int amount;
  final String productName;
  final String size;
  final String createdAt;

  ProductBaseInfo({
    required this.amount,
    required this.productName,
    required this.size,
    required this.createdAt,
  });

  factory ProductBaseInfo.fromJson(Map<String, Object?> json) {
    return ProductBaseInfo(
      amount: json['amount'] as int,
      productName: json['product_name'] as String,
      size: json['size'] as String,
      createdAt: json['created_at'] as String,
    );
  }
}

class DeliveredProduct {
  final DeliveryInfo deliveryInfo;
  final ProductBaseInfo productBaseInfo;

  DeliveredProduct({
    required this.deliveryInfo,
    required this.productBaseInfo,
  });

  factory DeliveredProduct.fromJson(Map<String, dynamic> json) {
    return DeliveredProduct(
      deliveryInfo: DeliveryInfo.fromJson(json['delivery_info'] ?? {}),
      productBaseInfo: ProductBaseInfo.fromJson(json['productbase_info'] ?? {}),
    );
  }
}
