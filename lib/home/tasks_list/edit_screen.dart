import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_new/database/my_database.dart';
import 'package:todo_app_new/database/task.dart';
import 'package:todo_app_new/dialog_utils.dart';
import 'package:todo_app_new/my_theme.dart';

class EditTaskScreen extends StatefulWidget {
  Task task;

  EditTaskScreen({required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  /*====================[Variables]=======================*/
  DateTime selectedDate = DateTime.now();

  /*======================================================*/

  /*====================[Methods]=======================*/
  void showDateDialog() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate:selectedDate ,   // widget.task.dateTime!
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (date != null) {
       widget.task.dateTime = date;
      setState(() {});
    }
  }

  void editTask() async {
    await MyDatabase.editTaskDetails(widget.task)
    .then((value) {
      showMessage(context, 'Task Updated Successfully', posActionName: 'OK',
          posAction: () {
            Navigator.pop(context);
          });
    })
    .onError((error, stackTrace) {
      showMessage(context, 'Error happened please try again',
          posActionName: 'OK', posAction: () {
            Navigator.pop(context);
          });
    })
    .timeout(const Duration(seconds: 3), onTimeout: () {
      showMessage(context, 'Task Updated Locally', posActionName: 'OK',
          posAction: () {
            Navigator.pop(context);
          });
    });
  }

  /*======================================================*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Container(
                color: MyTheme.lightPrimary,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .2,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        )),
                    Text(
                      'ToDO App',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 40),
                width: MediaQuery.of(context).size.width * .85,
                height: MediaQuery.of(context).size.height * .80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                 children: [
                   Text(
                     'Edit Task',
                     style:
                         Theme.of(context).textTheme.titleMedium?.copyWith(
                               color: Colors.black,
                               fontSize: 20,
                             ),
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   TextFormField(
                     initialValue: widget.task.title,
                     style:
                         Theme.of(context).textTheme.titleMedium!.copyWith(
                               color: Colors.black,
                               fontSize: 18,
                             ),
                     onChanged: (value) {
                       widget.task.title = value;
                     },
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   TextFormField(
                     initialValue: widget.task.description,
                     style:
                         Theme.of(context).textTheme.titleMedium!.copyWith(
                               color: Colors.black,
                               fontSize: 18,
                             ),
                     onChanged: (value) {
                       widget.task.description = value;
                     },
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('Select Date',
                           style: Theme.of(context)
                               .textTheme
                               .titleMedium!
                               .copyWith(fontSize: 20)),
                       IconButton(
                         onPressed: () {
                           showDateDialog();
                           print('weaeae');
                         },
                         icon: const Icon(
                           Icons.calendar_month_sharp,
                           color: Colors.blue,
                         ),
                       )
                     ],
                   ),
                   const SizedBox(
                     height: 20,
                   ),
                   Row(
                     children: [
                       Text(
                         DateFormat('yyyy-MM-dd').format(widget.task.dateTime!),
                         // '${task.dateTime!.year} / ${task.dateTime!.month}/ ${task.dateTime!.day} ',
                         style: Theme.of(context)
                             .textTheme
                             .bodyLarge!
                             .copyWith(fontSize: 18),
                         textAlign: TextAlign.start,
                       )
                     ],
                   ),
                   const Spacer(),
                   MaterialButton(
                     onPressed: () {
                       editTask();
                     },
                     color: Theme.of(context).primaryColor,
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30)),
                     minWidth: 200,
                     height: 55,
                     child: Text(
                       'Save Changes',
                       style: Theme.of(context)
                           .textTheme
                           .titleLarge!
                           .copyWith(
                               color: Colors.white,
                               fontWeight: FontWeight.bold),
                     ),
                   )
                 ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
