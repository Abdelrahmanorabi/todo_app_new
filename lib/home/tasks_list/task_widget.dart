import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_new/database/my_database.dart';
import 'package:todo_app_new/database/task.dart';
import 'package:todo_app_new/home/Provider/setting_provider.dart';
import 'package:todo_app_new/home/tasks_list/edit_screen.dart';
import 'package:todo_app_new/my_theme.dart';

import '../../dialog_utils.dart';

class TaskWidget extends StatelessWidget {
  Task task;

  TaskWidget({required this.task});

  @override
  Widget build(BuildContext context) {

    SettingProvider settingProvider = Provider.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EditTaskScreen(task: task)));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.4,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                    MyDatabase.deleteTask(task).then((value) {
                    showMessage(context, 'Task Deleted Successfully',
                        posActionName: 'Ok', posAction: () {
                      Navigator.pop(context);
                    });
                  }).onError((error, stackTrace) {
                    showMessage(
                        context, 'Something Went Wrong...\n try again later',
                        posActionName: 'Ok', posAction: () {
                      Navigator.pop(context);
                    });
                  }).timeout(const Duration(seconds: 3), onTimeout: () {
                    showMessage(context, 'Task deleted locally',
                        posActionName: 'Ok', posAction: () {
                      Navigator.pop(context);
                    });
                  });
                },
                icon: Icons.delete,
                label: 'Delete',
                backgroundColor: MyTheme.redColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              )
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: settingProvider.isDark()
                  ? MyTheme.darkTaskBackground
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                //1
                Container(
                  width: 5,
                  height: 60,
                  decoration: BoxDecoration(
                    color: task.isDone! ? MyTheme.greenColor : MyTheme.lightPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //2
                      Text(
                        task.title ?? '',
                        style: task.isDone!
                            ? Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.greenColor)
                            : Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(task.description!,
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: settingProvider.isDark()
                                ? Colors.white
                                : Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('${DateFormat.jm().format(task.dateTime!)} ',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),

                    ],
                  ),
                ),

                //3
                InkWell(
                  onTap: () {
                    MyDatabase.editIsDone(task);
                  },
                  child: task.isDone!
                      ? Text(
                          'Done',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.greenColor),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 4),
                          decoration: BoxDecoration(
                            color: task.isDone!
                                ? MyTheme.greenColor
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
