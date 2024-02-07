import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/user_model.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/components/bottom_navbar.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/history_screen_manager_role/history_screen_manager_role.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/home_screen_manager_role/home_screen_manager_role.dart';
import 'package:sandiq/presentation/screens/manager_role_screen/product_add_screen_manager_role/product_add_screen_manager_role.dart';
import 'package:sandiq/services/constants/colors.dart';

import '../store_keeper_screens/home_screen_store_keeper/components/build_drawer.dart';
import '../store_keeper_screens/home_screen_store_keeper/components/dialog_delete_account.dart';
import 'components/custom_appbar_manager.dart';

class MainHomeScreenManagerRole extends StatefulWidget {
  const MainHomeScreenManagerRole({super.key});

  @override
  State<MainHomeScreenManagerRole> createState() =>
      _MainHomeScreenManagerRoleState();
}

class _MainHomeScreenManagerRoleState extends State<MainHomeScreenManagerRole>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;
  bool isMenuTapped = true;
  late Future<User> _userFuture;
  UserService userService = UserService();

  void toggleMenu(bool value) {
    setState(() {
      isMenuTapped = value;
    });
    if (isMenuTapped) {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  List colors = [
    CustomColors.kTransparent,
    CustomColors.kPrimaryColor,
  ];



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
                        context,
                        user?.name ?? "Unknown",
                      );
                    },
                  );
                }
              },
            )
          : null,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 140.sp),
        child: CustomAppBarManager(onMenuTapped: toggleMenu),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          HomeScreenManagerRole(),
          ProductAddScreenManagerRole(),
          HistoryScreenManagerRole(),
        ],
      ),
      bottomNavigationBar: BottomNavBarManager(controller: tabController),
    );
  }
}
