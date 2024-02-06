import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'site_tab.dart';
import '../pages/home_page.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';
import '../pages/experience_page.dart';
import '../pages/games_page.dart';
import '../pages/my_work_page.dart';
import '../pages/skills_page.dart';

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
    _tabController = TabController(vsync: this, length: 7);
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

  List<Widget> _tabViews = const [
    HomePage(),
    AboutPage(),
    SkillsPage(),
    ExperiencePage(),
    MyWorkPage(),
    ContactPage(),
    GamesPage(),
  ];

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
                  _buildTab('SKILLS', Icons.gamepad, 2),
                  _buildTab('EXPERIENCE', Icons.work, 3),
                  _buildTab('MY WORK', Icons.palette_rounded, 4),
                  _buildTab('CONTACT', Icons.email, 5),
                  _buildTab('BORED?', Icons.flutter_dash, 6),
                ],
                onTap: (index) {
                  widget.navigationShell.goBranch(index);
                },
              ),
            ),
          ),
          Expanded(
              child: RotatedBox(
            quarterTurns: 1,
            child: TabBarView(
              controller: _tabController,
              children: _tabViews.map((widget) {
                return RotatedBox(
                  quarterTurns: 3,
                  child: widget,
                );
              }).toList(),
            ),
          )),
        ],
      ),
    ));
  }
}
