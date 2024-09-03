import 'package:untitled/core/services/time_formate.dart';

class TaskModel {
  String  description;
  String?  id;
  String  title;
   bool isDone;
   DateTime selectedDate;


  TaskModel({
     this.id,
    required this.title,
    required this.description,
     this.isDone =false,
    required this.selectedDate,
  });

   Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'selectedDate': formateDate(selectedDate).millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromFirestore(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      isDone: data['isDone'],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(data['selectedDate']),
    );
  }
}
