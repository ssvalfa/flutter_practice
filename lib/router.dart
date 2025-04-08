import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/match.dart';
import 'package:flutter_application_1/pages/upcoming_list.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/pages/teams/teams_page.dart';
import 'package:flutter_application_1/pages/feed_detailed.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/signup.dart';
import 'package:flutter_application_1/pages/match_detailed.dart';
import 'package:flutter_application_1/pages/upcoming_matches_detailed.dart';
import 'package:flutter_application_1/pages/teams/teams_detailed.dart';

import 'package:flutter_application_1/pages/upcoming_list.dart';
import 'package:flutter_application_1/services/pocketbase_service.dart';

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

final router = GoRouter(
  navigatorKey: _parentKey,
  redirect: (context, state) {
    final isAuthenticated = pocketBaseService.isAuthenticated();
    final isLoggingIn = state.matchedLocation == '/login';
    final isSigningUp = state.matchedLocation == '/signup';

    if (!isAuthenticated && !isLoggingIn && !isSigningUp) {
      return '/login'; // Redirect to login if not authenticated and not on login/signup
    }
    if (isAuthenticated && (isLoggingIn || isSigningUp)) {
      return '/'; // Redirect authenticated users away from login/signup pages
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const FeedPage()),
    GoRoute(
      path: '/feed/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return FeedDetailScreen(id: id); // Pass the id here
      },
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(
        path: '/matchdetail',
        builder: (context, state) => const MatchDetailPage()),
    GoRoute(path: '/teams', builder: (context, state) => const TeamsPage()),
    GoRoute(
      path: '/teams/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final extra = state.extra as Map<String, dynamic>?;
        return TeamsDetailedPage(
          id: id,
          title: extra?['title'] ?? 'Title',
        );
      },
    ),
    GoRoute(
      path: '/match/:id',
      builder: (context, state) {
        final match = state.extra as GameMatch;
        return UpcomingMatchesPage(match: match);
      },
    ),
    GoRoute(
        path: '/upcominglist',
        builder: (context, state) => const UpcomingMatchesListPage())
  ],
);
