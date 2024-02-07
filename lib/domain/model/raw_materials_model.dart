class RawMaterials {
  final int id;
  final String name;
  final String address;
  final List<ProductSet> productSets;
  final double totalPrice;
  final ProductSet productSet;
  final DataArray dataArray;
  final Product product;

  RawMaterials({
    required this.id,
    required this.name,
    required this.address,
    required this.productSets,
    required this.totalPrice,
    required this.productSet,
    required this.dataArray,
    required this.product,
  });

  factory RawMaterials.fromJson(Map<String, dynamic> json) {
    return RawMaterials(
      id: json['id'] is String ? int.tryParse(json['id']) ?? 0 : json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      productSets: (json['productsets'] as List<dynamic>?)
          ?.map((set) => ProductSet.fromJson(set))
          .toList() ??
          [],
      totalPrice: json['total_price'] is String
          ? double.tryParse(json['total_price']) ?? 0.0
          : json['total_price'] ?? 0.0,
      productSet: ProductSet.fromJson(json['productset'] ?? {}),
      dataArray: DataArray.fromJson(json['data_array'] ?? {}),
      product: Product.fromJson(json['product'] ?? {}),
    );
  }
}

class ProductSet {
  final int id;
  final double totalPrice;
  final List<DataArray> dataArray;

  ProductSet({
    required this.id,
    required this.totalPrice,
    required this.dataArray,
  });

  factory ProductSet.fromJson(Map<String, dynamic> json) {
    return ProductSet(
      id: json['id'] ?? 0,
      totalPrice: json['total_price'] ?? 0.0,
      dataArray: (json['data_array'] as List<dynamic>?)
          ?.map((data) => DataArray.fromJson(data))
          .toList() ??
          [],
    );
  }
}

class DataArray {
  final String name;
  final int allPrice;
  final List<Product> products;

  DataArray({
    required this.name,
    required this.allPrice,
    required this.products,
  });

  factory DataArray.fromJson(Map<String, dynamic> json) {
    return DataArray(
      name: json['name'] ?? '',
      allPrice: json['allPrice'] ?? 0,
      products: (json['products'] as List<dynamic>?)
          ?.map((product) => Product.fromJson(product))
          .toList() ??
          [],
    );
  }
}

class Product {
  final String name;
  final String size;
  final String price;
  final String amount;

  Product({
    required this.name,
    required this.size,
    required this.price,
    required this.amount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      size: json['size'] ?? '',
      price: json['price'] ?? '',
      amount: json['amount'] ?? '',
    );
  }
}
