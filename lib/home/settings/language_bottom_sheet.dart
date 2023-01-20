import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';
import 'package:todo_app_new/home/Provider/setting_provider.dart';
import 'package:todo_app_new/my_theme.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  /*===================[Variables]======================*/
  late SettingProvider settingProvider;

  /*====================================================*/
  /*===================[Methods]======================*/
  Widget getSelectedRow(String language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(color: MyTheme.lightPrimary),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade400
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language,
            style:
            Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          const Icon(
            Icons.check,
            size: 24,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

  Widget getUnselectedRow(String language) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language,
            style:
            Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }

  /*====================================================*/
  @override
  Widget build(BuildContext context) {
    settingProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration:  BoxDecoration(
        color: settingProvider.isDark()? MyTheme.darkScaffoldBackground : Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              settingProvider.changeLanguage('en');
            },
            child: (settingProvider.currentLanguage == 'en')
                ? getSelectedRow('English')
                : getUnselectedRow('English'),
          ),
          InkWell(
            onTap: () {
              settingProvider.changeLanguage('ar');
            },
            child: (settingProvider.currentLanguage == 'ar')
                ? getSelectedRow('العربية')
                : getUnselectedRow('العربية'),
          )
        ],
      ),
    );
  }
}
