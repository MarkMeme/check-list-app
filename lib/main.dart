import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/providers/AppConfigProvider.dart';
import 'package:to_do_app/task_details/edit_task.dart';
import 'package:to_do_app/theme_data.dart';

import 'home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AppConfigProvider(),
      child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  late AppConfigProvider provider ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    initSettings();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        EditTask.routeName: (context) => EditTask()
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }
  Future<void> initSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString("lang") ?? 'en';
    provider.changeLanguage(lang);
    String theme = prefs.getString("theme") ?? 'light' ;
    if (theme == 'dark'){
      provider.changeTheme(ThemeMode.dark);
    }
    else {
      provider.changeTheme(ThemeMode.light);
    }
  }
}
