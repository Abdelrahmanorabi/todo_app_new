import 'package:flutter/material.dart';
import 'package:todo_app_new/home/Provider/setting_provider.dart';
import 'package:todo_app_new/home/settings/setting_tab.dart';
import 'package:todo_app_new/home/tasks_list/tasks_list_tab.dart';
import 'package:todo_app_new/my_theme.dart';
import 'tasks_list/add_task_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class HomeScreen extends StatefulWidget {
  static const String routeName = 'HOME';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*====================[Variables]=======================*/
  int selectedIndex = 0;
  List<Widget> tabs = [TasksListTab(), SettingTab()];

  /*====================================================*/

  /*====================[Methods]=======================*/
  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (buildContext) {
          return AddTaskBottomSheet();
        });
  }

  /*====================================================*/

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title:   Text( AppLocalizations.of(context)!.app_title),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: settingProvider.isDark()? MyTheme.darkTaskBackground : Colors.white,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.settings),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }
}
