import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_new/database/my_database.dart';
import 'package:todo_app_new/database/task.dart';
import 'package:todo_app_new/date_utils.dart';

import '../../dialog_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  /*===================[Variables]=================*/
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   /*==============================================*/

  /*===================[Methods]=================*/


  // function to add task
  void addTask() {
    if (formKey.currentState?.validate() == true) {
      String title = titleController.text;
      String description = descriptionController.text;

      Task task = Task(
        title: title,
        description: description,
        dateTime: dateOnly(selectedDate),
          isDone: false,
      );
      showLoading(context, 'Loading........');
      MyDatabase.insertTask(task)
        .then((value) {
        // called when future function is completed  successfully
        hideLoading(context); // to hide/pop  showLoading()
        showMessage(context, 'Task Added Successfully', posActionName: 'OK',isCancelable: false,
            posAction: () {
          Navigator.pop(context); // to pop addTask bottomSheet
        });
      })
        .onError((error, stackTrace) {
        // called when future fails or has error
        hideLoading(context);
        showMessage(context, 'Error Something went wrong, try again later');
      })
        .timeout(
          const Duration(seconds: 3), onTimeout: () {
        // called after time if there is no internet and save date locally (cash)
        hideLoading(context);
        showMessage(context, 'Task saved locally',posActionName: 'OK',isCancelable: false,  posAction: () {
          Navigator.pop(context); // to pop addTask bottomSheet
        });
      });
    }
  }

  // function to select date from datePicker
  void showDateDialog() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (date != null) {
      selectedDate = date;
      setState(() {});
    }
  }

  /*==============================================*/
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .70,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              validator: (value) {
                if (value!.trim().isEmpty || value == null) {
                  return 'Please Enter Title';
                }
                return null;
              },
              controller: titleController,
              style: Theme.of(context).textTheme.titleSmall,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              validator: (value) {
                if (value!.trim().isEmpty || value == null) {
                  return 'Please Enter Description';
                }
                return null;
              },
              controller: descriptionController,
              style: Theme.of(context).textTheme.titleSmall,
              minLines: 4,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Date',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                    onPressed: () {
                      showDateDialog();
                    },
                    icon: const Icon(
                      Icons.calendar_month_sharp,
                      color: Colors.blue,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                DateFormat('yyyy/MM/dd').format(selectedDate),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text(
                  'Add',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
