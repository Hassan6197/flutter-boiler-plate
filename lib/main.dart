import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_export.dart';
import 'core/di/injection_container.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// Main entry point of the application
/// 
/// Dependencies are initialized before running the app
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize all dependencies (DI Container)
  await initializeDependencies();
  
  // Configure system UI and preferences
  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init()
  ]);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => ThemeBloc(
            ThemeState(
              themeType: PrefUtils().getThemeData(),
              fontFamily: PrefUtils().getFontFamily(),
              fontSizeScale: PrefUtils().getFontSizeScale(),
            ),
          ),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              // Create ThemeHelper with current state values
              final themeHelper = ThemeHelper(
                themeType: state.themeType,
                fontFamily: state.fontFamily,
                fontSizeScale: state.fontSizeScale,
              );
              
              return MaterialApp(
                theme: themeHelper.themeData(),
                title: 'Flutter Boilerplate',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale(
                    'en',
                    '',
                  ),
                ],
                initialRoute: AppRoutes.initialRoute,
                routes: AppRoutes.routes,
              );
            },
          ),
        );
      },
    );
  }
}
