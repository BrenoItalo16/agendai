import 'package:agendai/core/alert/alert_area.dart';
import 'package:agendai/core/theme/app_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // await Future.delayed(const Duration(seconds: 4));

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
    return RepositoryProvider(
      create: (_) => AppTheme(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData.light().copyWith(
          colorScheme: ThemeData.light().colorScheme.copyWith(
                background: Colors.white,
              ),
        ),
        locale: DevicePreview.locale(context),
        builder: (context, child) {
          final newChild = Stack(
            children: [
              if (child != null) child,
              const AlertArea(),
            ],
          );
          return DevicePreview.appBuilder(context, newChild);
        },
      ),
    );
  }
}
