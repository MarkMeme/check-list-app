import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/firebase_task.dart';

CollectionReference<Task> getTaskClollection(){
  return FirebaseFirestore.instance.collection('task')
      .withConverter(fromFirestore: ((snapshot, options) => Task.fromJson(snapshot.data()!) ),
      toFirestore: (value, options) => value.toJson(),);
}
 addTaskFirebase(Task task){
  var collection = getTaskClollection();
  var docref = collection.doc();
  task.id = docref.id ;
  return docref.set(task);
}

Future<void> deleteTaskFirebase(Task task){
  return getTaskClollection().doc(task.id).delete();
}

Future<void> updateTaskFirebase(Task task){
  return getTaskClollection().doc(task.id).update(
    task.toJson());
}