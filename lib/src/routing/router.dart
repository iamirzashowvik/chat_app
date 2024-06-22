import 'package:chat_app/src/features/authentication/view/auth_view.dart';
import 'package:chat_app/src/features/authentication/view/splash_view.dart';
import 'package:chat_app/src/features/chat/view/Thead_View.dart';
import 'package:chat_app/src/features/chat/view/chat_view.dart';
import 'package:chat_app/src/features/settings/view/settings_view.dart';
import 'package:chat_app/src/utils/models/user.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (context, state) => AuthView(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => ChatView(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsView(),
    ),
    GoRoute(
      path: '/thread',
      builder: (context, state) {
        final userData =
            state.extra as KUser; // Retrieve UserData from the extra parameter
        return ThreadView(user: userData);
      },
    ),
  ],
);

class AppRouters {
  static void goHome() {
    router.go('/');
  }

  static void goAuth() {
    router.go('/auth');
  }

  static void goSplash() {
    router.go('/splash');
  }

  static void goSettings() {
    router.go('/settings');
  }

  static void goToThread(KUser userData) {
    router.go('/thread', extra: userData);
  }
}
