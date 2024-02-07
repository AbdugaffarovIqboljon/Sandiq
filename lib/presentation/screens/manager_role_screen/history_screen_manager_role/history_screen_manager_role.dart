import 'package:flutter/material.dart';
import 'package:sandiq/domain/model/build_history_tile.dart';
import 'package:sandiq/domain/model/history_model.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/services/constants/colors.dart';
import 'package:sandiq/services/util_services.dart';

class HistoryScreenManagerRole extends StatefulWidget {
  const HistoryScreenManagerRole({Key? key}) : super(key: key);

  @override
  State<HistoryScreenManagerRole> createState() =>
      _HistoryScreenManagerRoleState();
}

class _HistoryScreenManagerRoleState extends State<HistoryScreenManagerRole> {
  late List<History> historyData = [];
  late ProductService productService;
  UtilServices util = UtilServices();

  @override
  void initState() {
    super.initState();
    productService = ProductService();
    fetchHistoryData();
  }

  Future<void> fetchHistoryData() async {
    List<History> data = await productService.fetchHistoryData();
    setState(() {
      historyData = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: SingleChildScrollView(
        primary: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Buyurtmalar tarixi',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
              HistoryMaterialTile(historyData: historyData, util: util),
            ],
          ),
        ),
      ),
    );
  }
}
