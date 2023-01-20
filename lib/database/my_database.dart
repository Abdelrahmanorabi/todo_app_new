import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app_new/database/task.dart';
import '../date_utils.dart';

/*
   1- first create collection (table) => [Tasks]
   2- insert new document in this collection => document reflect as complete object
   3- in this document add  { id , title , description } in class Task
    you can add complete object once Task task
*/

class MyDatabase {
  // function to create instance (object) new collection
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (documentSnapshot, snapshotOptions) {
      return Task.fromFireStore(documentSnapshot.data()!);
    }, toFirestore: (task, options) {
      return task.toFireStore();
    });
  }

  // function to insert[add] new task
  static Future<void> insertTask(Task task) {
    var tasksCollection = getTasksCollection(); // create new collection [table]
    var taskDocument = tasksCollection.doc(); // create new document in this collection

    task.id = taskDocument.id; // id from taskDocument generated automatically
    return taskDocument
        .set(task); // take the task data and put it in this document
  }

  // function to delete task
  static Future<void> deleteTask(Task task) {
    var tasksCollection = getTasksCollection();
    var taskDocument = tasksCollection.doc(task.id);

    return taskDocument.delete();
  }




  // function to check if isDone
  static void editIsDone(Task task) {
    var tasksCollection = getTasksCollection();
    var taskDocument = tasksCollection.doc(task.id);
     taskDocument.update({'isDone': task.isDone! ? false : true});
  }


  // function to update task
  static Future<void> editTaskDetails(Task task){
    var tasksCollection = getTasksCollection();
    var taskDocument = tasksCollection.doc(task.id);
    return taskDocument.update({
      'title': task.title,
      'description': task.description,
      'dateTime': dateOnly(task.dateTime!).millisecondsSinceEpoch,
    });

  }






  /*You can use one of these functions getAllTasks() or listenForTaskUpdates  */

  // function to receive data from Firebase but it [read data once ]
  static Future<QuerySnapshot<Task>> getAllTasks(DateTime selectedDate) {
    Future<QuerySnapshot<Task>> querySnapshot = getTasksCollection()
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .get();
    return querySnapshot;
  }

  // function to receive data from Firebase but it [listen for realtime Updates ]
  static Stream<QuerySnapshot<Task>> listenForTaskUpdates(DateTime selectedDate) {
    Stream<QuerySnapshot<Task>> querySnapshot = getTasksCollection()
        .where('dateTime',isEqualTo: dateOnly(selectedDate).millisecondsSinceEpoch)
        .snapshots();
    return querySnapshot;
  }
}
