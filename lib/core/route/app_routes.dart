import 'package:agendai/features/auth/pages/auth/auth_page.dart';
import 'package:agendai/features/auth/pages/login/login_page.dart';
import 'package:agendai/features/auth/pages/sign_up/sign_up_page.dart';
import 'package:agendai/features/home/pages/base/base_page.dart';
import 'package:agendai/features/intro/pages/force_update/force_update_page.dart';
import 'package:agendai/features/intro/pages/maintenance/maintenance_page.dart';
import 'package:agendai/features/intro/pages/not_found/not_found_page.dart';
import 'package:agendai/features/intro/pages/onboarding/onboarding_page.dart';
import 'package:agendai/features/intro/pages/splash/splash_page.dart';
import 'package:agendai/features/professional/pages/professional_details/professional_details_page.dart';
import 'package:agendai/features/professional/pages/professional_ratings/professional_ratings_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return null;
  },
  errorBuilder: (context, state) => const NotFoundPage(),
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthPage(),
        routes: [
          GoRoute(
            path: AppRoutes.signup.path,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: AppRoutes.login.path,
            builder: (context, state) => const LoginPage(),
          ),
        ]),
    GoRoute(
      path: AppRoutes.maintenance,
      builder: (context, state) => const MaintenancePage(),
    ),
    GoRoute(
      path: AppRoutes.forceUpdate,
      builder: (context, state) => const ForceUpdatePage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const BasePage(),
    ),
    GoRoute(
        path: AppRoutes.professionalDetails(id: ':id'),
        builder: (context, state) => ProfessionalDetailsPage(
              id: state.pathParameters['id']!,
            ),
        routes: [
          GoRoute(
            path: AppRoutes.professionalRatings.path,
            builder: (context, state) => ProfessionalRatingsPage(
              id: state.pathParameters['id']!,
            ),
          ),
        ]),
  ],
);

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String maintenance = '/maintenance';
  static const String forceUpdate = '/force-update';
  static const String home = '/home';

  static String professionalDetails({required String id}) =>
      '/professionals/$id';

  static const AppRoute signup = AppRoute(
    fullpath: '/auth/sign-up',
    path: 'sign-up',
  );
  static const AppRoute login = AppRoute(
    fullpath: '/auth/login',
    path: 'login',
  );

  static AppRoutesWithId professionalRatings = AppRoutesWithId(
    path: 'ratings',
    buildFullPath: (id) => '/professionals/$id/ratings',
  );
}

class AppRoute {
  const AppRoute({required this.fullpath, required this.path});

  final String fullpath;
  final String path;
}

class AppRoutesWithId {
  const AppRoutesWithId({required this.path, required this.buildFullPath});

  final String path;
  final Function(String id) buildFullPath;

  String fullPath({required String id}) => buildFullPath(id);
}
