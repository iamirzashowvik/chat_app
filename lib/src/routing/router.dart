import 'package:chat_app/src/features/authentication/view/auth_view.dart';
import 'package:chat_app/src/features/authentication/view/splash_view.dart';
import 'package:chat_app/src/features/chat/view/chat_view.dart';
import 'package:chat_app/src/features/settings/view/settings_view.dart';
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
}
