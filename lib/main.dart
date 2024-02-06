import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roboli_site/pages/home_page.dart';

import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/experience_page.dart';
import 'pages/games_page.dart';
import 'pages/my_work_page.dart';
import 'pages/skills_page.dart';

void main() {
  runApp(const SiteApp());
}

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
      child: _SiteTab(
        icon: Icon(iconData),
        title: Text(
          name,
          style: GoogleFonts.anton(
            textStyle: const TextStyle(letterSpacing: 1.1),
          ),
        ),
        isExpanded: _tabController.index == index
      ),
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

final _router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return ScaffoldNavigationSideBar(
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const HomePage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/about',
              builder: (BuildContext context, GoRouterState state) {
                return const AboutPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/skills',
              builder: (BuildContext context, GoRouterState state) {
                return const SkillsPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/experience',
              builder: (BuildContext context, GoRouterState state) {
                return const ExperiencePage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/work',
              builder: (BuildContext context, GoRouterState state) {
                return const MyWorkPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/contact',
              builder: (BuildContext context, GoRouterState state) {
                return const ContactPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/games',
              builder: (BuildContext context, GoRouterState state) {
                return const GamesPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

class _SiteTab extends StatefulWidget {
  const _SiteTab({
    required this.title,
    required this.icon,
    required this.isExpanded,
  });

  final Text title;
  final Icon icon;
  final bool isExpanded;

  @override
  _SiteTabState createState() => _SiteTabState();
}

class _SiteTabState extends State<_SiteTab>
    with SingleTickerProviderStateMixin {
  late Animation<double> _titleSizeAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _iconFadeAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _titleSizeAnimation = _controller.view;
    _titleFadeAnimation = _controller.drive(CurveTween(curve: Curves.easeOut));
    _iconFadeAnimation = _controller.drive(Tween<double>(begin: 0.6, end: 1));
    if (widget.isExpanded) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(_SiteTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        FadeTransition(
          opacity: _iconFadeAnimation,
          child: widget.icon,
        ),
        const SizedBox(height: 12),
        FadeTransition(
          opacity: _titleFadeAnimation,
          child: SizeTransition(
            axis: Axis.vertical,
            axisAlignment: -1,
            sizeFactor: _titleSizeAnimation,
            child: Center(child: ExcludeSemantics(child: widget.title)),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class SiteApp extends StatelessWidget {
  const SiteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      title: 'Roboli\'s Site',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black87,
        tabBarTheme: const TabBarTheme(
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.white,
        ),
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        ).apply(bodyColor: Colors.white),
      ),
      routerConfig: _router,
    );
  }
}
