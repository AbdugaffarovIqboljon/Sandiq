class User {
  final int id;
  final String name;
  final String phone;
  final String username;
  final Warehouse? warehouse;
  final ObjectData? object;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.username,
    this.warehouse,
    this.object,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      username: json['username'] ?? '',
      warehouse: json['warehouse'] != null
          ? Warehouse.fromJson(json['warehouse'])
          : null,
      object: json['object'] != null ? ObjectData.fromJson(json['object']) : null,
      role: json['role'] ?? '',
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

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

class ObjectData {
  final int id;
  final String name;
  final String address;
  final Worker? worker;

  ObjectData({
    required this.id,
    required this.name,
    required this.address,
    this.worker,
  });

  factory ObjectData.fromJson(Map<String, dynamic> json) {
    return ObjectData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      worker: json['worker'] != null ? Worker.fromJson(json['worker']) : null,
    );
  }
}

class Worker {
  final int id;
  final String name;
  final String username;
  final String phone;

  Worker({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
