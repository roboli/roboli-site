import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const SiteApp());
}

class ScaffoldNavigationSideBar extends StatelessWidget {
  const ScaffoldNavigationSideBar({
      required this.navigationShell,
      required this.children,
      Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldNavigationSideBar'));

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  const NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('About'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.gamepad),
                    label: Text('Skills'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.work),
                    label: Text('Experience'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.palette_rounded),
                    label: Text('My Work'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.email),
                    label: Text('Contact'),
                  ),
                  const NavigationRailDestination(
                    icon: Icon(Icons.flutter_dash),
                    label: Text('Bored?'),
                  ),
                ],
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: (value) {
                  navigationShell.goBranch(value);
                },
              ),
            ),
            Expanded(
              child: AnimatedBranchContainer(
                currentIndex: navigationShell.currentIndex,
                children: children,
              ),
            ),
          ],
        ));
      },
    );
  }
}

final _router = GoRouter(
  routes: [
    StatefulShellRoute(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return navigationShell;
      },
      navigatorContainerBuilder: (
        BuildContext context,
        StatefulNavigationShell navigationShell,
        List<Widget> children
      ) {
        return ScaffoldNavigationSideBar(
          navigationShell: navigationShell,
          children: children,
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

// Example from:
// https://github.com/flutter/packages/blob/0744fe6fdb31933d05d11699e7f44e1dd2c63e48/packages/go_router/example/lib/others/custom_stateful_shell_route.dart#L227
class AnimatedBranchContainer extends StatelessWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      (int index, Widget navigator) {
        return AnimatedScale(
          scale: index == currentIndex ? 1 : 1.5,
          duration: const Duration(milliseconds: 400),
          child: AnimatedOpacity(
            opacity: index == currentIndex ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            child: _branchNavigatorWrapper(index, navigator),
          ),
        );
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}

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
