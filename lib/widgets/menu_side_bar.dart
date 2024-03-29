import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/pages/about_page.dart';
import 'package:roboli_site/pages/contact_page.dart';
import 'package:roboli_site/pages/experience_page.dart';
import 'package:roboli_site/pages/home_page.dart';
import 'package:roboli_site/pages/my_work_page.dart';

import 'site_tab.dart';

const minHeight = 900.0;

class MenuSideBar extends StatefulWidget {
  final String page;
  final int index;

  MenuSideBar({super.key, required this.page}) : index = pages[page] ?? 0;

  @override
  State<StatefulWidget> createState() => _MenuSideBar();
}

class _MenuSideBar extends State<MenuSideBar> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 5, initialIndex: widget.index);
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..drive(Tween<double>(begin: 0, end: 1))
      ..forward();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if router changed page
    if (_tabController.index != widget.index) {
      _tabController.animateTo(widget.index);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
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
      child: FadeTransition(
        opacity: _animationController,
        child: Row(
          children: [
            Container(
              width: 125 * MediaQuery.of(context).textScaler.scale(0.9),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 32),
              color: Colors.grey[900],
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: minHeight),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: TabBar(
                    controller: _tabController,
                    labelPadding: EdgeInsets.zero,
                    indicatorColor: Colors.transparent,
                    tabs: [
                      _buildTab('HOME', Icons.home, 0),
                      _buildTab('ABOUT', Icons.person, 1),
                      _buildTab('EXPERIENCE', Icons.work, 2),
                      _buildTab('MY WORK', Icons.palette_rounded, 3),
                      _buildTab('CONTACT', Icons.email, 4),
                    ],
                    onTap: (index) {
                      updateRouter(index);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: RotatedBox(
                quarterTurns: 1,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildTabView(const HomePage()),
                    _buildTabView(const AboutPage()),
                    _buildTabView(const ExperiencePage()),
                    _buildTabView(const MyWorkPage()),
                    _buildTabView(const ContactPage()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildTabView(Widget child) {
    return RotatedBox(
      quarterTurns: -1,
      child: child,
    );
  }

  void updateRouter(int index) {
    String page = 'home';

    switch (index) {
      case 0:
        page = 'home';
        break;

      case 1:
        page = 'about';
        break;

      case 2:
        page = 'experience';
        break;

      case 3:
        page = 'work';
        break;

      case 4:
        page = 'contact';
        break;
    }

    GoRouter.of(context).goNamed('page', pathParameters: {'page': page});
  }
}
