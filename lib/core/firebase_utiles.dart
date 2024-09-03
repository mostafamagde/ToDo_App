import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:untitled/core/services/time_formate.dart';

import '../modules/models/task_model.dart';

class FirebaseUtiles {
  static String? userid;

  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection(userid!)
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFireStore(),
        );
  }

  static Future<void> addTask(TaskModel task) {
    var docRef = getCollection().doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<TaskModel>> getTasks(DateTime time) async {
    var data = await getCollection()
        .where("selectedDate",
            isEqualTo: formateDate(time).millisecondsSinceEpoch)
        .get();
    List<TaskModel> taskList =
        data.docs.map((toElement) => toElement.data()).toList();
    return taskList;
  }

  static Stream<QuerySnapshot<TaskModel>> getStream(DateTime selectedtime) {
    var streamRef = getCollection().where("selectedDate",
        isEqualTo: formateDate(selectedtime).millisecondsSinceEpoch);
    return streamRef.snapshots();
  }

  static deleteTask(TaskModel task) async {
    var data = await getCollection();
    data.doc(task.id).delete();
  }

  static isDone(TaskModel task) async {
    var data = await getCollection();
    data.doc(task.id).update(
      {
        "isDone": !task.isDone,
      },
    );
  }

  static editTask(TaskModel task)  {
    var data = getCollection();
    data.doc(task.id).update(
      {
        "title": task.title,
        "description": task.description,
        "selectedDate": formateDate(task.selectedDate).millisecondsSinceEpoch,
      },
    );
  }

  static Future<bool> createAccount(
      String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
    return Future.value(false);
  }

  static Future<bool> login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      FirebaseUtiles.userid = credential.user?.uid;

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        return Future.value(false);
      }

      return Future.value(false);
    }
  }
}
