// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/carscatalogpage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/pages/newspage.dart';

import 'pages/homepage.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

Page<void> noTransitionPageBuilder(
    BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child; // No animation
    },
  );
}

final router = GoRouter(navigatorKey: _parentKey, routes: [
  ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) => HomePage(
            child: child,
          ),
      routes: [
        GoRoute(
          path: '/',
          name: 'news',
          parentNavigatorKey: _shellKey,
          pageBuilder: (context, state) => noTransitionPageBuilder(
            context,
            state,
            const Newspage(),
          ),
        ),
        GoRoute(
          path: CarsCatalogPage
              .route, 
          parentNavigatorKey: _shellKey,
          name: 'cars',
          pageBuilder: (context, state) =>
              noTransitionPageBuilder(context, state, const CarsCatalogPage()),
        ),
      ]),
]);
