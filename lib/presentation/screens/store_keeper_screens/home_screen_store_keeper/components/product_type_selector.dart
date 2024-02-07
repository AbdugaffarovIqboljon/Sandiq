import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/incoming_product_screen/incoming_product_screen.dart';

class ProductTypeSelector extends StatefulWidget {
  final ProductService productService;
  final void Function(Product)? onSelected;
  final TextEditingController textEditingController;
  final Product? selectedProduct;

  const ProductTypeSelector({
    Key? key,
    required this.productService,
    this.onSelected,
    required this.textEditingController,
    this.selectedProduct,
  }) : super(key: key);

  @override
  State<ProductTypeSelector> createState() => _ProductTypeSelectorState();
}

class _ProductTypeSelectorState extends State<ProductTypeSelector> {
  late Future<List<Product>> productsFuture;
  Product? selectedProduct;

  @override
  void initState() {
    super.initState();
    productsFuture = widget.productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedProduct != null)
          ListTile(
            minVerticalPadding: 0,
            tileColor: Colors.blueGrey.shade50,
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide.none,
            ),
            title: Text(
              selectedProduct!.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            onTap: () {
              setState(() {
                selectedProduct = null;
              });
            },
          )
        else
          FutureBuilder<List<Product>>(
            future: productsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!;
                return DropdownButtonFormField2<Product>(
                  barrierDismissible: true,
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.blueGrey.shade50,
                    ),
                    padding: const EdgeInsets.only(bottom: 20),
                  ),
                  items: products.map((product) {
                    return DropdownMenuItem<Product>(
                      value: product,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              product.size,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (Product? newValue) {
                    if (widget.onSelected != null && newValue != null) {
                      widget.onSelected!(newValue);
                      setState(() {
                        selectedProduct = newValue;
                        selectedProductId = selectedProduct?.id ?? 0;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    enabled: true,
                    isCollapsed: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 10,
                    ),
                  ),
                  isExpanded: false,
                  hint: Text(
                    "Maxsulotni tanlang",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return products.map<Widget>((Product product) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          color: Colors.blueGrey.shade50,
                        ),
                        width: 1,
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(product.size),
                        ),
                      );
                    }).toList();
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error fetching products: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          ),
      ],
    );
  }
}
