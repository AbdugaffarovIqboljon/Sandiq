import 'package:flutter/material.dart';
import 'package:sandiq/services/constants/colors.dart';

import 'components/my_body_list_tile.dart';

class HistoryScreenManagerRole extends StatelessWidget {
  const HistoryScreenManagerRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kWhite,
      body: MyBodyListTile(),
    );
  }
}
