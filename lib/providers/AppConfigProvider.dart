import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_funs.dart';
import '../model/firebase_task.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.system;
  bool isNewDone = false;

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (newTheme == appTheme) {
      return;
    } else {
      appTheme = newTheme;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', appTheme == ThemeMode.dark ?  'dark' : "light");
    notifyListeners();
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (newLanguage == appLanguage) {
      return;
    } else {
      appLanguage = newLanguage;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', appLanguage);
    notifyListeners();
  }

  changeIsDone(bool isDone) {
    if (isDone == isNewDone) {
      return;
    } else {
      isNewDone = isDone;
    }
    notifyListeners();
  }

  void editTaskInFirebase(Task task) {
    updateTaskFirebase(task);
    notifyListeners();
  }

  static List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  addTaskFromFirebase() async {
    QuerySnapshot<Task> querySnapshot = await getTaskCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// each task in its date

    taskList = taskList.where((task) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(task.date);
      if (selectedDate.month == dateTime.month &&
          selectedDate.year == dateTime.year &&
          selectedDate.day == dateTime.day) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }
}
