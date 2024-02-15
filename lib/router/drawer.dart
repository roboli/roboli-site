import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roboli_site/router/main_panel.dart';

class ScaffoldNavigationDrawer extends StatefulWidget {
  const ScaffoldNavigationDrawer({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldNavigationDrawer'));

  final StatefulNavigationShell navigationShell;

  @override
  State<StatefulWidget> createState() => _ScaffoldNavigationDrawer();
}

class _ScaffoldNavigationDrawer extends State<ScaffoldNavigationDrawer>
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

  Widget _buildTab(String name, IconData iconData, Color color, int index) {
    return ListTile(
      leading: Icon(
        iconData,
        color: color,
      ),
      title: Text(name),
      onTap: () {
        widget.navigationShell.goBranch(index);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(child: SizedBox()),
            _buildTab('HOME', Icons.home, iconColor, 0),
            const Divider(),
            _buildTab('ABOUT', Icons.person, iconColor, 1),
            const Divider(),
            _buildTab('EXPERIENCE', Icons.work, iconColor, 2),
            const Divider(),
            _buildTab('MY WORK', Icons.palette_rounded, iconColor, 3),
            const Divider(),
            _buildTab('CONTACT', Icons.email, iconColor, 4),
            const Divider(),
            _buildTab('BORED?', Icons.flutter_dash, iconColor, 5),
            const Divider(),
          ],
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
