// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class Product {
//   int? id; // Primary key
//   String name;
//   String phoneNumber;
//   String productType;
//   double productAmount;
//
//   Product({
//     this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.productType,
//     required this.productAmount,
//   });
//
//   // Convert Product object to a Map
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'phoneNumber': phoneNumber,
//       'productType': productType,
//       'productAmount': productAmount,
//     };
//   }
//
//   // Create a Product object from a Map
//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'],
//       name: map['name'],
//       phoneNumber: map['phoneNumber'],
//       productType: map['productType'],
//       productAmount: map['productAmount'],
//     );
//   }
// }
//
// class DatabaseHelper {
//   static Database? _database;
//   static const String tableName = 'products';
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//
//     _database = await initDatabase();
//     return _database!;
//   }
//
//   Future<Database> initDatabase() async {
//     String path = await getDatabasesPath();
//     String databasePath = join(path, 'your_database_name.db');
//
//     return await openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: (Database db, int version) async {
//         await db.execute('''
//           CREATE TABLE $tableName(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             name TEXT,
//             phoneNumber TEXT,
//             productType TEXT,
//             productAmount REAL
//           )
//         ''');
//       },
//     );
//   }
//
//   Future<int> insertProduct(Product newProduct) async {
//     final db = await database;
//     return await db.insert(tableName, newProduct.toMap());
//   }
//
//   Future<int> deleteProduct(int id) async {
//     final db = await database;
//     return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
//   }
//
//   Future<List<Product>> getProducts() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(tableName);
//
//     return List.generate(maps.length, (i) {
//       return Product(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         phoneNumber: maps[i]['phoneNumber'],
//         productType: maps[i]['productType'],
//         productAmount: maps[i]['productAmount'],
//       );
//     });
//   }
// }

class Product {
  int id;
  String name;
  int amount;
  String size;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.amount,
    required this.size,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      amount: json['amount'] ?? 0,
      size: json['size'] ?? '',
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
    );
  }
}