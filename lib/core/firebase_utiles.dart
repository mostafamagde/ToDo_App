import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/core/services/time_formate.dart';

import '../modules/models/task_model.dart';

class FirebaseUtiles {
  static CollectionReference<TaskModel> getcollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFireStore(),
        );
  }

  static Future<void> addTask(TaskModel task) {
    var docref = getcollection().doc();
    task.id = docref.id;
    return docref.set(task);
  }

  static Future<List<TaskModel>> getTasks(DateTime time) async {
    var data = await getcollection()
        .where("selectedDate",
            isEqualTo: formateDate(time).millisecondsSinceEpoch)
        .get();
    List<TaskModel> taskList =
        data.docs.map((toElement) => toElement.data()).toList();
    return taskList;
  }

  static Stream<QuerySnapshot<TaskModel>> getStream(DateTime selectedtime) {
    var streamref = getcollection().where("selectedDate",
        isEqualTo: formateDate(selectedtime).millisecondsSinceEpoch);
    return streamref.snapshots();
  }

  static deletetask(TaskModel task) {
    var data = getcollection();
    data.doc(task.id).delete();
  }

  static updatetask(TaskModel task) {
    var data = getcollection();
    data.doc(task.id).update(
      {
        "isDone": !task.isDone,
      },
    );
  }
}
