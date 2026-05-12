import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:route/home/tabs/fav/fav.dart';
import 'package:route/home/tabs/map/map.dart';
import 'package:route/providers/app_language_provider.dart';
import 'package:route/providers/app_theme_provider.dart';
import 'package:route/providers/event_list_provider.dart';
import 'package:route/providers/user_provider.dart';
import 'package:route/utils/app_routes.dart';
import 'package:route/utils/app_theme.dart';
import 'auth/login/login_screen.dart';
import 'auth/register/register_screen.dart';
import 'firebase_options.dart';
import 'home/add_event/add_event.dart';
import 'home/tabs/profile/profile_tab.dart';
import 'l10n/app_localizations.dart';
import 'home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
        child: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginRouteName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appLanguageProvider.appLanguage),
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.mapRouteName: (context) => MapTab(),
        AppRoutes.profileRouteName: (context) => ProfileTab(),
        AppRoutes.favRouteName: (context) => FavTab(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
         AppRoutes.addEventRouteName: (context) => AddEvent(),
      },
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: appThemeProvider.appThemeMode,
    );
  }
}
