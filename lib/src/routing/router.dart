import 'package:chat_app/src/features/authentication/view/auth_view.dart';
import 'package:chat_app/src/features/chat/view/chat_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AuthView(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => ChatView(),
    ),
  ],
);
