class ProductHistory {
  final int id;
  final String name;
  final int amount;
  final double price;
  final String size;
  final String totalPrice;
  final bool status;
  final DateTime date;
  final Delivery delivery;
  final Warehouse warehouse;

  ProductHistory({
    required this.id,
    required this.name,
    required this.amount,
    required this.price,
    required this.size,
    required this.totalPrice,
    required this.status,
    required this.date,
    required this.delivery,
    required this.warehouse,
  });

  factory ProductHistory.fromJson(Map<String, Object?> json) {
    return ProductHistory(
      id: json['id'] as int,
      name: json['name'] as String,
      amount: json['amount'] as int,
      price: json['price'] as double,
      size: json['size'] as String,
      totalPrice: json['total_price'] as String,
      status: json['status'] as bool,
      date: DateTime.parse(json['date'] as String),
      delivery: Delivery.fromJson(json['delivery'] as Map<String, Object?>),
      warehouse: Warehouse.fromJson(json['warehouse'] as Map<String, Object?>),
    );
  }
}

class Delivery {
  final int id;
  final String name;
  final String phone;

  Delivery({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory Delivery.fromJson(Map<String, Object?> json) {
    return Delivery(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );
  }
}

class Warehouse {
  final int id;
  final String name;
  final String address;

  Warehouse({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Warehouse.fromJson(Map<String, Object?> json) {
    return Warehouse(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
    );
  }
}
