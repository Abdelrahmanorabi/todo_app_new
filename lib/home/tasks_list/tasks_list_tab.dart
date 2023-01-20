import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/database/my_database.dart';
import 'package:todo_app_new/home/Provider/setting_provider.dart';
import 'package:todo_app_new/home/tasks_list/task_widget.dart';

import '../../database/task.dart';

class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of (context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null) {
                return;
              }
              selectedDate = date;
              setState(() {});
            },
            leftMargin: 20,
            showYears: true,
            monthColor:settingProvider.isDark()? Colors.white:Colors.black,
            dayColor:settingProvider.isDark()? Colors.white:Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            locale: 'en_ISO',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              stream: MyDatabase.listenForTaskUpdates(selectedDate),
              builder: (buildContext, asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  // add button try again to reload page تحت ال تكست ويدجيت دي
                  return const Text(
                      'Error Loading Data, Please Try again Later');
                }
                else if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                else {
                  List<Task>? data = asyncSnapshot.data?.docs
                      .map((element) => element.data())
                      .toList();

                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TaskWidget(
                        task: data[index],
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
