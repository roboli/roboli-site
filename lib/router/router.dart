import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roboli_site/helpers/constants.dart';
import 'package:roboli_site/router/pager.dart';
import 'package:roboli_site/router/side_bar.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home',
    ),
    GoRoute(
      name: 'page',
      path: '/:page',
      builder: (BuildContext context, GoRouterState state) {
        return LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > screenBreakpoint) {
            return ScaffoldNavigationSideBar(
              page: state.pathParameters['page'] ?? '',
            );
          } else {
            return ScaffoldNavigationPager(
              page: state.pathParameters['page'] ?? '',
            );
          }
        });
      },
    ),
  ],
);
