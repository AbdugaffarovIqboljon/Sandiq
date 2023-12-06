import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/history_screen_manager_role/history_screen_manager_role.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/home_screen_manager_role/home_screen_manager_role.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/product_add_screen_manager_role/product_add_screen_manager_role.dart';
import 'package:sandiq/presentation/screens/store_keeper_screens/home_screen_store_keeper/components/custom_appbar.dart';
import 'package:sandiq/services/constants/colors.dart';

class MainHomeScreenManagerRole extends StatefulWidget {
  const MainHomeScreenManagerRole({super.key});

  @override
  State<MainHomeScreenManagerRole> createState() =>
      _MainHomeScreenManagerRoleState();
}

class _MainHomeScreenManagerRoleState extends State<MainHomeScreenManagerRole>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List colors = [
    CustomColors.kTransparent,
    CustomColors.kPrimaryColor,
  ];

  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, 140.sp),
      //   child: CustomAppBarStoreKeeper(
      //     leadingOnPressed: () {},
      //     scaffoldKey: _scaffoldKey,
      //   ),
      // ),
      extendBody: true,
      body: TabBarView(
        controller: controller,
        children: const [
          HomeScreenManagerRole(),
          ProductAddScreenManagerRole(),
          HistoryScreenManagerRole(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 80, right: 80, bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: CustomColors.kWhite,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(0, 1),
              spreadRadius: 1,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        child: TabBar(
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: CustomColors.kPrimaryColor,
              width: 5,
            ),
          ),
          indicatorColor: CustomColors.kPrimaryColor,
          labelColor: CustomColors.kPrimaryColor,
          unselectedLabelColor: Colors.grey.shade400,
          dividerColor: CustomColors.kTransparent,
          controller: controller,
          tabs: const [
            Tab(icon: Icon(CupertinoIcons.home)),
            Tab(icon: Icon(CupertinoIcons.add_circled)),
            Tab(icon: Icon(Icons.history)),
          ],
        ),
      ),
    );
  }
}
