import 'package:cloud_firestore/cloud_firestore.dart';

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
}
