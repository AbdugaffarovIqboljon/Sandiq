class History {
  final int id;
  final String status;
  final String description;
  final DateTime createdAt;
  final List<Product> products;

  History({
    required this.id,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.products,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    List<Product> parsedProducts = [];
    if (json['products'] != null) {
      parsedProducts = List<Product>.from(
        json['products'].map((product) => Product.fromJson(product)),
      );
    }

    return History(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      products: parsedProducts,
    );
  }
}

class Product {
  final int id;
  final String name;
  final int amount;
  final String size;

  Product({
    required this.id,
    required this.name,
    required this.amount,
    required this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      amount: json['amount'] ?? 0,
      size: json['size'] ?? '',
    );
  }
}
