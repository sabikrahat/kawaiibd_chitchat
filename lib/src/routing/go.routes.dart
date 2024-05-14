import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/page_not_found/page_not_found.dart';
import '../constant/get.platform.dart';
import '../features/auth/presentation/auth.view.dart';
import '../features/chat.room/presentation/chat.room.view.dart';
import '../features/maintenance.break/presentation/maintenance.break.view.dart';
import '../features/messaging/presentation/messaging.dart';
import '../features/settings/presentation/setting.view.dart';
import '../utils/logger/logger_helper.dart';
import 'app.routes.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.homeRoute,
  errorBuilder: (_, __) => const KPageNotFound(error: '404 - Page not found!'),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.homeRoute,
      name: ChatRoomView.name,
      builder: (_, __) => const ChatRoomView(),
    ),
    GoRoute(
      path: AppRoutes.authRoute,
      name: AuthenticationView.name,
      builder: (_, __) => const AuthenticationView(),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.signinRoute.substring(1),
          name: AuthenticationView.signinName,
          builder: (_, __) => const AuthenticationView(),
        ),
        GoRoute(
          path: AppRoutes.signupRoute.substring(1),
          name: AuthenticationView.signupName,
          builder: (_, __) => const AuthenticationView(isSignup: true),
        ),
      ],
    ),
    GoRoute(
      path: '${AppRoutes.messageRoute}/:uid',
      name: MessagingView.name,
      builder: (_, state) => MessagingView(
        uid: state.pathParameters['uid'] ??
            FirebaseAuth.instance.currentUser?.uid ??
            'no-uid-found',
      ),
    ),
    GoRoute(
      path: AppRoutes.settingsRoute,
      name: SettingsView.name,
      builder: (_, __) => const SettingsView(),
    ),
    GoRoute(
      path: AppRoutes.maintenanceBreakRoute,
      name: MaintenanceBreak.name,
      builder: (_, __) => const MaintenanceBreak(),
    ),
  ],
  redirect: (context, state) {
    final path = '/${state.fullPath?.split('/').last.toLowerCase()}';
    final lgdn = FirebaseAuth.instance.currentUser != null;
    log.f('Path: $path');

    /// Maintenance Break
    if (AppRoutes.isMaintenanceBreak) {
      log.f(
          'Redirecting to ${AppRoutes.maintenanceBreakRoute} from $path Reason: Maintenance Break.');
      return AppRoutes.maintenanceBreakRoute;
    }
    if (!AppRoutes.isMaintenanceBreak &&
        path == AppRoutes.maintenanceBreakRoute) {
      log.f(
          'Redirecting to ${AppRoutes.homeRoute} from $path Reason: Maintenance Break ended.');
      return AppRoutes.homeRoute;
    }

    /// Auth
    if (!lgdn && AppRoutes.allAuthRequiredRoutes.contains(path)) {
      log.f(
          'Redirecting to ${AppRoutes.authRoute} from $path Reason: Authentication.');
      return AppRoutes.authRoute;
    }
    if (lgdn && AppRoutes.authRelatedRoutes.contains(path)) {
      log.f(
          'Redirecting to ${AppRoutes.homeRoute} from $path Reason: Already logged in.');
      return AppRoutes.homeRoute;
    }
    return null;
  },
);

extension GoRouteExtension on BuildContext {
  goPush<T>(String route) =>
      pt.isWeb ? GoRouter.of(this).go(route) : GoRouter.of(this).push(route);
}
