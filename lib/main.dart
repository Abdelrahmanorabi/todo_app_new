import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/home/Provider/setting_provider.dart';
import 'package:todo_app_new/home/home_page.dart';
 import 'package:todo_app_new/my_theme.dart';
import 'firebase_options.dart';
 import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /* this line used only if you want to  make your app work only locally*/
  // FirebaseFirestore.instance.disableNetwork();

  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return SettingProvider();
      },
      child: MyApp()));
}


class MyApp extends StatelessWidget {
  late SettingProvider settingProvider;
  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
       },
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: settingProvider.currentTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settingProvider.currentLanguage),
    );
  }
}
