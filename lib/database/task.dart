// data class to deal with Task collection

class Task {
  static String collectionName = 'tasks';

  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  // constructor to initialize data
  Task({
    this.id,
    this.title,
    this.description,
    this.dateTime,
     this.isDone,
  });

  // named constructor to convert data received from firebase  to objects
  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
             isDone: data['isDone']);

  // method to convert data / send data from this class  to firebase
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
       'isDone': isDone,
    };
  }
}
