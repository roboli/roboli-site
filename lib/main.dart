import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

class _ScaffoldNavigationSideBar extends State<ScaffoldNavigationSideBar> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                  const Tab(
                    icon: Icon(Icons.home),
                    text: 'Home',
                  ),
                  const Tab(
                    icon: Icon(Icons.person),
                    text: 'About',
                  ),
                  const Tab(
                    icon: Icon(Icons.gamepad),
                    text: 'Skills',
                  ),
                  const Tab(
                    icon: Icon(Icons.work),
                    text: 'Experience',
                  ),
                  const Tab(
                    icon: Icon(Icons.palette_rounded),
                    text: 'My Work',
                  ),
                  const Tab(
                    icon: Icon(Icons.email),
                    text: 'Contact',
                  ),
                  const Tab(
                    icon: Icon(Icons.flutter_dash),
                    text: 'Bored?',
                  ),
                ],
                onTap: (index) {
                  widget.navigationShell.goBranch(index);
                },
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const HomePage(),
                    const AboutPage(),
                    const SkillsPage(),
                    const ExperiencePage(),
                    const MyWorkPage(),
                    const ContactPage(),
                    const GamesPage(),
                  ],
                )
              ),
            ],
          ),
        )
      );
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


class SiteApp extends StatelessWidget {
  const SiteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Roboli\'s Site',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Welcome'),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('About Me'),
      ),
    );
  }
}

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('My Skills'),
      ),
    );
  }
}

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('My Experience'),
      ),
    );
  }
}

class MyWorkPage extends StatelessWidget {
  const MyWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Hello MyWork'),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Contact Me'),
      ),
    );
  }
}

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Bored?'),
      ),
    );
  }
}
