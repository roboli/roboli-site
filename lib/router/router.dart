import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/router/app_bar.dart';

import 'side_bar.dart';
import '../pages/home_page.dart';
import '../pages/about_page.dart';
import '../pages/contact_page.dart';
import '../pages/experience_page.dart';
import '../pages/games_page.dart';
import '../pages/my_work_page.dart';

GoRouter buildRouter(double screenSize) {
  return GoRouter(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          if (screenSize > screenBreakpoint) {
            return ScaffoldNavigationSideBar(
              navigationShell: navigationShell,
            );
          } else {
            return ScaffoldNavigationAppBar(
              navigationShell: navigationShell,
            );
          }
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
}
