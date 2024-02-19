import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roboli_site/widgets/menu_manager.dart';

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
        return MenuManager(
          page: state.pathParameters['page'] ?? '',
        );
      },
    ),
  ],
);
