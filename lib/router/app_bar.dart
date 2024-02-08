import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roboli_site/router/main_panel.dart';

class ScaffoldNavigationAppBar extends StatefulWidget {
  const ScaffoldNavigationAppBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldNavigationAppBar'));

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() => _ScaffoldNavigationAppBar();
}

class _ScaffoldNavigationAppBar extends State<ScaffoldNavigationAppBar>
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

  Widget _buildTab(String name, IconData iconData) {
    return Tab(
      icon: Icon(iconData),
      text: name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          tabs: [
            _buildTab('HOME', Icons.home),
            _buildTab('ABOUT', Icons.person),
            _buildTab('SKILLS', Icons.gamepad),
            _buildTab('EXPERIENCE', Icons.work),
            _buildTab('MY WORK', Icons.palette_rounded),
            _buildTab('CONTACT', Icons.email),
            _buildTab('BORED?', Icons.flutter_dash),
          ],
          onTap: (index) {
            widget.navigationShell.goBranch(index);
          },
        ),
      ),
      body: SafeArea(
        child: MainPanel(
          index: _tabController.index,
          child: widget.navigationShell,
        ),
      ),
    );
  }
}
