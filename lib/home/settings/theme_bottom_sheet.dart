import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/home/Provider/setting_provider.dart';
import 'package:todo_app_new/my_theme.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  /*===================[Variables]======================*/
  late SettingProvider settingProvider;

  /*====================================================*/
  /*===================[Methods]======================*/
  Widget getSelectedRow(String theme) {
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
            theme,
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

  Widget getUnselectedRow(String theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            theme,
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
              settingProvider.changeTheme(ThemeMode.light);
            },
            child: (settingProvider.isDark())
                ? getUnselectedRow('Light')
                : getSelectedRow('Light'),
          ),
          InkWell(
            onTap: () {
              settingProvider.changeTheme(ThemeMode.dark);
            },
            child: (settingProvider.isDark())
                ? getSelectedRow('Dark')
                : getUnselectedRow('Dark'),
          )
        ],
      ),
    );
  }
}
