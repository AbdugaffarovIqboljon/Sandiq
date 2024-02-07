import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sandiq/domain/model/user_model.dart';

class CustomAppBarManager extends StatefulWidget {
  final void Function(bool) onMenuTapped;

  const CustomAppBarManager({
    Key? key,
    required this.onMenuTapped,
  }) : super(key: key);

  @override
  State<CustomAppBarManager> createState() =>
      _CustomAppBarManagerState();
}

class _CustomAppBarManagerState extends State<CustomAppBarManager> {
  late Future<User> _userFuture;
  UserService userService = UserService();

  @override
  void initState() {
    _userFuture = userService.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        User? user = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildAppBarManager('Loading...', 'Loading...');
        } else if (snapshot.connectionState == ConnectionState.active) {
          return buildAppBarManager("${user?.name}", "${user?.object?.name}");
        } else {
          return buildAppBarManager(
            user?.name ?? 'Unknown',
            user?.object?.name ?? 'Unknown',
          );
        }
      },
    );
  }

  /// #build AppBar
  AppBar buildAppBarManager(String title, String objectName) {
    return AppBar(
      leading: Align(
        alignment: const Alignment(0, -1),
        child: IconButton(
          onPressed: () {
            widget.onMenuTapped(true);
          },
          icon: Image(
            image: const AssetImage("assets/icons/ic_menu.png"),
            height: 28.sp,
            width: 28.sp,
            color: const Color(0xFFF6F6F3),
          ),
        ),
      ),
      actions: [
        Align(
          alignment: const Alignment(0, -1),
          child: IconButton(
            onPressed: () {},
            icon: Image(
              image: const AssetImage("assets/icons/ic_bell.png"),
              height: 25.sp,
              width: 25.sp,
              color: const Color(0xFFF6F6F3),
            ),
          ),
        ),
        SizedBox(width: 5.sp),
      ],
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 23.sp,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60.sp),
          bottomRight: Radius.circular(60.sp),
        ),
      ),
      backgroundColor: const Color(0xFF00827B),
      bottom: PreferredSize(
        preferredSize: Size(120.sp, 60.sp),
        child: Transform.translate(
          offset: Offset(0.sp, 30.sp),
          child: Container(
            width: 180.sp,
            height: 60.sp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(color: Colors.blueGrey.shade100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: const AssetImage("assets/icons/ic_warehouse.png"),
                  height: 33.sp,
                  width: 33.sp,
                ),
                Text(
                  objectName,
                  style: TextStyle(
                    color: const Color(0xFF3E309E),
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
