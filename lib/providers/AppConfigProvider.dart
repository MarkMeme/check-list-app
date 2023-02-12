import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_funs.dart';
import '../model/firebase_task.dart';
class AppConfigProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  bool isNewDone = false ;
  void changeLanguage(String newLanguage){
    if(newLanguage == appLanguage){
      return;
    }
    else{
      appLanguage = newLanguage ;
    }
    notifyListeners();
  }

  changeIsDone(bool isDone){
    if (isDone == isNewDone){
      return ;
    }
    else {
      isNewDone = isDone ;
    }
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme){
    if(newTheme == appTheme){
      return;
    }
    else{
      appTheme = newTheme ;
    }
    notifyListeners();
  }

  void editTaskInFirebase(Task task){
    updateTaskFirebase(task);
    notifyListeners();
  }

  static List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  addTaskFromFirebase() async{
    QuerySnapshot<Task> querySnapshot = await getTaskClollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();


    /// each task in its date

    taskList = taskList.where((task) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(task.date);
      if(selectedDate.month == dateTime.month
          && selectedDate.year == dateTime.year
          && selectedDate.day == dateTime.day
      ){
        return true ;
      }
      return false ;
    }).toList();
    notifyListeners();

  }



  }
