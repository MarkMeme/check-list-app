import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/firebase_task.dart';

CollectionReference<Task> getTaskCollection(){
  return FirebaseFirestore.instance.collection('task')
      .withConverter(fromFirestore: ((snapshot, options) => Task.fromJson(snapshot.data()!) ),
      toFirestore: (value, options) => value.toJson(),);
}
 addTaskFirebase(Task task){
  var collection = getTaskCollection();
  var docRef = collection.doc();
  task.id = docRef.id ;
  return docRef.set(task);
}

Future<void> deleteTaskFirebase(Task task){
  return getTaskCollection().doc(task.id).delete();
}

Future<void> updateTaskFirebase(Task task){
  return getTaskCollection().doc(task.id).update(
    task.toJson());
}