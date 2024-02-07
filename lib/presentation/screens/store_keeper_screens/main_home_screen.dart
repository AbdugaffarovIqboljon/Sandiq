import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/product_model.dart';
import 'package:sandiq/domain/model/user_model.dart';

import 'cart_screen_store_keeper/cart_screen.dart';
import 'history_screen_store_keeper/history_screen.dart';
import 'home_screen_store_keeper/components/build_drawer.dart';
import 'home_screen_store_keeper/components/custom_appbar.dart';
import 'home_screen_store_keeper/components/custom_bottom_navbar.dart';
import 'home_screen_store_keeper/components/dialog_delete_account.dart';
import 'home_screen_store_keeper/home_screen_store_keeper.dart';

class MainHomeScreenStoreKeeper extends StatefulWidget {
  const MainHomeScreenStoreKeeper({super.key});

  @override
  State<MainHomeScreenStoreKeeper> createState() =>
      _MainHomeScreenStoreKeeperState();
}

class _MainHomeScreenStoreKeeperState extends State<MainHomeScreenStoreKeeper>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;
  bool isMenuTapped = true;
  late Future<User> _userFuture;
  UserService userService = UserService();
  ProductService productService = ProductService();

  void toggleMenu(bool value) {
    setState(() {
      isMenuTapped = value;
    });
    if (isMenuTapped) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  @override
  void initState() {
    _userFuture = userService.fetchUserData();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: isMenuTapped == true
          ? FutureBuilder<User>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildDrawer('Loading...', 'Loading...', () {});
                } else if (snapshot.connectionState == ConnectionState.active) {
                  User? user = snapshot.data;
                  return buildDrawer(
                      user?.name ?? "Unknown", user?.phone ?? "Unknown", () {});
                } else {
                  User? user = snapshot.data;
                  return buildDrawer(
                    user?.name ?? "Unknown",
                    user?.phone ?? "Unknown",
                    () {
                      buildShowDialogDeleteAccount(
                          context, user?.name ?? "Unknown");
                    },
                  );
                }
              },
            )
          : null,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 140.sp),
        child: CustomAppBarStoreKeeper(
          onMenuTapped: toggleMenu,
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: tabController),
      extendBody: true,
      body: TabBarView(
        controller: tabController,
        children: const [
          HomeScreenStoreKeeper(),
          CartScreen(),
          HistoryScreen(),
        ],
      ),
    );
  }
}
