import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home/home_page.dart';
import 'package:to_do_app/task_details/task_item.dart';

import '../firebase_funs.dart';
import '../model/firebase_task.dart';
import '../providers/AppConfigProvider.dart';
import '../theme_data.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key}) : super(key: key);
  static const String routeName = 'editScreen';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  var keyForm = GlobalKey<FormState>();
  late Task task ;


  String title = '';
  String description = '';
  DateTime selectedDate = DateTime.now();
@override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments as TaskDetailsArgs;
      String title = args.task.title;
      String description = args.task.description;
      int date = selectedDate.millisecondsSinceEpoch;
      date = args.task.date;
      task = args.task ;
      selectedDate = DateTime.fromMillisecondsSinceEpoch(date);
      titleController.text = task.title ;
      descriptionController.text = task.description ;
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.toDoList,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 23),
          color: Theme.of(context).textTheme.headline1?.color,
          margin:
              const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: Wrap(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.taskTask,

                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      AppLocalizations.of(context)!.taskDetails,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Form(
                        key: keyForm,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: titleController,
                              /*initialValue: title,
                              onChanged: (text) {
                                title = text;
                              },

                               */
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'error' ;
                                 //   AppLocalizations.of(context)!.pleaseEnterTitle;
                                }else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  border: const UnderlineInputBorder(
                                      ),
                                  hintText: AppLocalizations.of(context)!.theTitle,
                                 hintStyle: Theme.of(context).textTheme.headline6,
                                 // prefixText: title,
                                  //prefixStyle: Theme.of(context).textTheme.headline6
                              ),


                            ),
                            /*const Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),*/
                            const SizedBox(
                              height: 7,
                            ),
                            TextFormField(
                              controller: descriptionController ,
                              /*initialValue: description,
                              onChanged: (text) {
                                description = text;
                              },

                               */
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Provider.of<AppConfigProvider>(context).appTheme == ThemeMode.light
                                        ? MyThemeData.blackColor
                                        : MyThemeData.whiteColor,
                                  )),
                                  hintText: AppLocalizations.of(context)!.description,
                                  hintStyle: Theme.of(context).textTheme.headline6),
                              maxLines: 4,
                              minLines: 2,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .enterTheDescription;
                                }
                                else {
                                  return null;
                                }
                              },
                            ),
                            /*const Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),*/
                          ],
                        )),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      AppLocalizations.of(context)!.selectDate,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 18),
                    InkWell(
                      onTap: () {
                        showCalendar();
                      },
                      child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                        margin: EdgeInsets.all(30),
                        child: ElevatedButton(
                          onPressed: () {
                            editTask(task);
                            Provider.of<AppConfigProvider>(context,listen: false).editTaskInFirebase(task);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  MyThemeData.primaryLight)),
                          child: Text(
                            AppLocalizations.of(context)!.edit,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (chosenDate != null) {

      setState(() {
        selectedDate = chosenDate;
      });
    }
  }

  void editTask(Task task) {
    if (keyForm.currentState?.validate() == true) {
      task.title = titleController.text ;
      task.description = descriptionController.text ;
      task.date = selectedDate.millisecondsSinceEpoch;
      print(task.title);
      setState(() {

      });
      Navigator.pop(context);

    }
  }
}
