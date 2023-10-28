import 'package:agendai/core/firebase/messaging/app_messaging.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/utils/no_glow_behavior.dart';
import 'package:agendai/core/widgets/alert/alert_area.dart';
import 'package:agendai/features/auth/data/session/cubit/session_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/di/di.dart';
import 'core/flavor/flavor_config.dart';
import 'core/route/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> bootstrap(FlavorConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies(config);

  getIt<AppMessaging>().configure();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    DevicePreview(
      builder: (_) => const App(),
      enabled: true,
      // enabled: config.flavor == AppFlavor.dev,
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme();
    return RepositoryProvider.value(
      value: theme,
      child: BlocProvider.value(
        value: getIt<SessionCubit>(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
          ],
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: theme.white,
            colorScheme: ThemeData.light().colorScheme.copyWith(
                  background: Colors.white,
                ),
            //? Customize field info
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: theme.primary,
              selectionHandleColor: theme.primary,
              selectionColor: theme.primary.withOpacity(0.4),
            ),
            highlightColor: theme.primary.withOpacity(0.1),
            splashColor: theme.primary.withOpacity(0.1),
          ),
          locale: DevicePreview.locale(context),
          builder: (context, child) {
            final newChild = ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: Stack(
                children: [
                  if (child != null) child,
                  const AlertArea(),
                ],
              ),
            );
            return DevicePreview.appBuilder(context, newChild);
          },
        ),
      ),
    );
  }
}
