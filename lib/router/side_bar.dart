import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roboli_site/router/main_panel.dart';

import 'site_tab.dart';

class ScaffoldNavigationSideBar extends StatefulWidget {
  const ScaffoldNavigationSideBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldNavigationSideBar'));

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() => _ScaffoldNavigationSideBar();
}

class _ScaffoldNavigationSideBar extends State<ScaffoldNavigationSideBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
   }

  Widget _buildTab(String name, IconData iconData, int index) {
    return RotatedBox(
      quarterTurns: -1,
      child: SiteTab(
          icon: Icon(iconData),
          title: Text(
            name,
            style: GoogleFonts.anton(
              textStyle: const TextStyle(letterSpacing: 1.1),
            ),
          ),
          isExpanded: _tabController.index == index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          Container(
            width: 125 * MediaQuery.of(context).textScaler.scale(0.9),
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: RotatedBox(
              quarterTurns: 1,
              child: TabBar(
                controller: _tabController,
                labelPadding: EdgeInsets.zero,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: [
                  _buildTab('HOME', Icons.home, 0),
                  _buildTab('ABOUT', Icons.person, 1),
                  _buildTab('EXPERIENCE', Icons.work, 2),
                  _buildTab('MY WORK', Icons.palette_rounded, 3),
                  _buildTab('CONTACT', Icons.email, 4),
                  _buildTab('BORED?', Icons.flutter_dash, 5),
                ],
                onTap: (index) {
                  widget.navigationShell.goBranch(index);
                },
              ),
            ),
          ),
          Expanded(
            child: MainPanel(
              index: _tabController.index,
              child: widget.navigationShell,
              )
          ),
        ],
      ),
    ));
  }
}
