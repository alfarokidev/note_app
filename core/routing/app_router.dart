import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/notes/presentation/pages/notes_page.dart';
import '../../features/notes/presentation/pages/edit_note_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/providers/auth_notifier.dart';

part 'app_router.g.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late StreamSubscription _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRouter.home,

    redirect: (context, state) {
      final user = ref.watch(authNotifierProvider).value;
      final isLoggedIn = user != null;
      final isAuthRoute =
          state.matchedLocation == AppRouter.login ||
          state.matchedLocation == AppRouter.register;

      if (!isLoggedIn && !isAuthRoute) {
        return AppRouter.login;
      }

      if (isLoggedIn && isAuthRoute) {
        return AppRouter.home;
      }

      return null;
    },
    routes: AppRouter._routes,
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.matchedLocation}')),
    ),
  );
}

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';
  static const String editNote = '/edit-note';
  static const String createNote = '/create-note';

  static List<RouteBase> get _routes => [
    GoRoute(
      path: login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: register,
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: home,
      name: 'home',
      builder: (context, state) => const NotesPage(),
    ),
    GoRoute(
      path: editNote,
      name: 'edit-note',
      builder: (context, state) {
        final noteId = state.uri.queryParameters['id'];
        return EditNotePage(noteId: noteId);
      },
    ),
    GoRoute(
      path: createNote,
      name: 'create-note',
      builder: (context, state) => const EditNotePage(),
    ),
  ];
}
