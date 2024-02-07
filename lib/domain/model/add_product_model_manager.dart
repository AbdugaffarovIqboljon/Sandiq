class AddProduct {
  String name;
  int product;
  int amount;
  ObjectClass objectClass;

  AddProduct({
    required this.name,
    required this.product,
    required this.amount,
    required this.objectClass,
  });

  factory AddProduct.fromJson(Map<String, dynamic> json) {
    return AddProduct(
      name: json['name'] as String,
      product: json['product'] as int,
      amount: json['amount'] as int,
      objectClass: ObjectClass.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'product': product,
      'amount': amount,
      'object': objectClass.toJson(),
    };
  }
}

class ObjectClass {
  int object;
  String description;

  ObjectClass({
    required this.object,
    required this.description,
  });

  factory ObjectClass.fromJson(Map<String, dynamic> json) {
    return ObjectClass(
      object: json['object'] as int,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'object': object,
      'description': description,
    };
  }
}
