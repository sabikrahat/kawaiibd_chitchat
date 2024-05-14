class AppRoutes {
  ///
  /// isMaintenanceBreak is a global variable that is set to true when the app
  static const isMaintenanceBreak = false;

  ///
  static const String homeRoute = '/';
  static const String authRoute = '/auth';
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String messageRoute = '/message';
  static const String settingsRoute = '/settings';
  static const String basicSettingsRoute = '/basic';
  static const String advancedSettingsRoute = '/advanced';
  static const String maintenanceBreakRoute = '/maintenance-break';

  static const List<String> allRoutes = [
    homeRoute,
    authRoute,
    signinRoute,
    signupRoute,
    messageRoute,
    settingsRoute,
    basicSettingsRoute,
    advancedSettingsRoute,
  ];

  static final List<String> allAuthRequiredRoutes = [...allRoutes]
    ..remove(authRoute)
    ..remove(signinRoute)
    ..remove(signupRoute);

  static final List<String> authRelatedRoutes = [
    authRoute,
    signinRoute,
    signupRoute,
  ];
}
