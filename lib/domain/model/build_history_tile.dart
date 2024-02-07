import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/history_model.dart';
import 'package:sandiq/services/util_services.dart';

class HistoryMaterialTile extends StatelessWidget {
  const HistoryMaterialTile({
    super.key,
    required this.historyData,
    required this.util,
  });

  final List<History> historyData;
  final UtilServices util;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 570.sp,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        primary: true,
        shrinkWrap: true,
        itemCount: historyData.length,
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemBuilder: (BuildContext context, int index) {
          final reversedIndex = historyData.length - 1 - index;
          final history = historyData[reversedIndex];
          return Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                vertical: 1,
                horizontal: 5,
              ),
              clipBehavior: Clip.antiAlias,
              collapsedBackgroundColor: Colors.blueGrey.shade50,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              backgroundColor: Colors.blueGrey.shade50,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
              title: Row(
                children: [
                  const Spacer(flex: 1),
                  Text(
                    'Buyurtma raqami: ${history.id}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5,
                    ),
                  ),
                  const Spacer(flex: 3),
                  Text(
                    util.formatDateHistory("${history.createdAt}"),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5,
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
              trailing: history.status == "tasdiqlandi"
                  ? const Image(
                      image: AssetImage("assets/icons/ic_checkmark.png"),
                      height: 25,
                      width: 25,
                    )
                  : history.status == "qaytarildi"
                      ? const Image(
                          image: AssetImage("assets/icons/ic_x_mark.png"),
                          height: 25,
                          width: 25,
                        )
                      : const Image(
                          image: AssetImage(
                            "assets/icons/ic_incomplete_mark.png",
                          ),
                          height: 23,
                          width: 23,
                        ),
              childrenPadding: EdgeInsets.only(left: 15.sp),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: history.products.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        final historyProducts = history.products[index];
                        return Text(
                          "Maxsulot: ${historyProducts.name}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Holati: ${history.status}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Tavsif: ${history.description}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
