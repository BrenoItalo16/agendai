import 'package:go_router/go_router.dart';
import '../../features/intro/pages/onboarding/onboarding_page.dart';
import '../../features/intro/pages/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(path: AppRoutes.productDetails(':id')),
  ],
);

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static String productDetails(String id) => '/products/$id';
}
