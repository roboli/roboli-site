import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldNavigationDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldNavigationDrawer({super.key, required this.navigationShell});

  Widget _buildTab(BuildContext context, String name, IconData iconData, int index) {
    final color = Theme.of(context).primaryColor;

    return ListTile(
      leading: Icon(
        iconData,
        color: navigationShell.currentIndex == index ? Colors.grey : color,
      ),
      title: Text(name),
      onTap: () {
        navigationShell.goBranch(index);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(child: SizedBox()),
            _buildTab(context, 'HOME', Icons.home, 0),
            const Divider(),
            _buildTab(context, 'ABOUT', Icons.person, 1),
            const Divider(),
            _buildTab(context, 'EXPERIENCE', Icons.work, 2),
            const Divider(),
            _buildTab(context, 'MY WORK', Icons.palette_rounded, 3),
            const Divider(),
            _buildTab(context, 'CONTACT', Icons.email, 4),
            const Divider(),
            _buildTab(context, 'BORED?', Icons.flutter_dash, 5),
            const Divider(),
          ],
        ),
      ),
      body: SafeArea(
        child: navigationShell,
      ),
    );
  }
}
