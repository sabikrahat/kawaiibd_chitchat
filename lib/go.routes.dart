import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import 'app.routes.dart';
import 'src/modules/auth/view/auth.dart';
import 'src/modules/home/home.dart';
import 'src/modules/maintenance.break/maintenance.break.dart';
import 'src/modules/profile/profile.dart';
import 'src/modules/settings/view/setting.view.dart';
import 'src/shared/page_not_found/page_not_found.dart';
import 'src/utils/logger/logger_helper.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutes.homeRoute,
  errorBuilder: (_, __) => const KPageNotFound(error: '404 - Page not found!'),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.homeRoute,
      name: HomeView.name,
      builder: (_, __) => const HomeView(),
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
      path: '${AppRoutes.profileRoute}/:uid',
      name: ProfileView.name,
      builder: (_, state) =>
          ProfileView(uid: state.pathParameters['uid'] ?? '724282'),
    ),
    GoRoute(
      path: AppRoutes.settingsRoute,
      name: SettingsView.name,
      builder: (_, __) => const SettingsView(),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.basicSettingsRoute.substring(1),
          name: SettingsView.basicName,
          builder: (_, __) => const SettingsView(),
        ),
        GoRoute(
          path: AppRoutes.advancedSettingsRoute.substring(1),
          name: SettingsView.advancedName,
          builder: (_, __) => const SettingsView(initialIndex: 1),
        ),
      ],
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
