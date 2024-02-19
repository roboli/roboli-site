import 'package:flutter/material.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/helpers/device.dart';

import 'menu_pager.dart';
import 'menu_side_bar.dart';

class MenuManager extends StatelessWidget {
  final String page;

  const MenuManager({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    if (isWebMobile) {
      return MenuPager(
        page: page,
      );
    } else {
      final size = MediaQuery.of(context).size;

      if (size.width > screenWBreakpoint && size.height > screenHBreakpoint) {
        return MenuSideBar(
          page: page,
        );
      } else {
        return MenuPager(
          page: page,
        );
      }
    }
  }
}
