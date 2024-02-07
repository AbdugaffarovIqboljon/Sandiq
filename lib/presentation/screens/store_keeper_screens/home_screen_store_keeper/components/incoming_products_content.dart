import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_delivery.dart';
import 'package:sandiq/services/util_services.dart';

class IncomingProductsContent extends StatelessWidget {
  const IncomingProductsContent({
    super.key,
    required this.productList,
  });

  final List<DeliveredProduct> productList;
  @override
  Widget build(BuildContext context) {
    UtilServices util = UtilServices();

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      shrinkWrap: true,
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final deliveredProduct = productList[index];
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
                const Spacer(),
                Text(
                  '${index + 1}. ${deliveredProduct.productBaseInfo.productName}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(flex: 6),
                Text(
                  '${deliveredProduct.productBaseInfo.amount} ${deliveredProduct.productBaseInfo.size}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ],
            ),
            childrenPadding: REdgeInsets.only(right: 50.sp),
            children: [
              Text(
                "Ismi: ${deliveredProduct.deliveryInfo.name}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Telefon raqami: ${deliveredProduct.deliveryInfo.phone}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Sanasi: ${util.formatDateTime(deliveredProduct.productBaseInfo.createdAt)}",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
