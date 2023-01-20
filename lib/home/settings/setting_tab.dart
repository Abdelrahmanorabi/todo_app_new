import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/home/Provider/setting_provider.dart';
import 'package:todo_app_new/home/settings/theme_bottom_sheet.dart';
import 'package:todo_app_new/my_theme.dart';

import 'language_bottom_sheet.dart';

class SettingTab extends StatefulWidget {
  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  /*===================[Variables]======================*/
  /*====================================================*/

  /*===================[Methods]======================*/

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return LanguageBottomSheet();
        });
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (_) {
          return ThemeBottomSheet();
        });
  }

  /*====================================================*/

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: const EdgeInsets.only(top: 20, left: 20),
              decoration: BoxDecoration(
                  color: settingProvider.isDark()
                      ? MyTheme.darkScaffoldBackground
                      : Colors.white,
                  border: Border.all(width: 0.2, color: MyTheme.lightPrimary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    settingProvider.currentLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      showLanguageBottomSheet();
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                      size: 26,
                    ),
                  ),
                  // Icon( Icons.arrow_drop_down,)
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: const EdgeInsets.only(top: 20, left: 20),
              decoration: BoxDecoration(
                  color: settingProvider.isDark()
                      ? MyTheme.darkScaffoldBackground
                      : Colors.white,
                  border: Border.all(width: 0.2, color: MyTheme.lightPrimary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (settingProvider.isDark()
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      showThemeBottomSheet();
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                      size: 26,
                    ),
                  ),
                  // Icon( Icons.arrow_drop_down,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
