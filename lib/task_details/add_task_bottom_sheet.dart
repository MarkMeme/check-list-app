import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_funs.dart';

import '../model/firebase_task.dart';
import '../providers/AppConfigProvider.dart';
import '../theme_data.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String title = '';

  String description = '';
  var keyForm = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Wrap(children: [
      SingleChildScrollView(
          reverse: true,
          child: Container(
            foregroundDecoration: const BoxDecoration(),
            padding: const EdgeInsets.all(18),
            color: provider.appTheme == ThemeMode.dark
                ? MyThemeData.blackColor
                : MyThemeData.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.addNewTask,
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
                          onChanged: (text) {
                            title = text;
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'erroe';
                              //AppLocalizations.of(context)!.pleaseEnterTitle;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              border: const UnderlineInputBorder(
                                  borderRadius: BorderRadius.zero),
                              hintText:
                                  AppLocalizations.of(context)!.enterYourTask,
                              hintStyle: Theme.of(context).textTheme.headline4),
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (text) {
                            description = text;
                          },
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: provider.appTheme == ThemeMode.light
                                    ? MyThemeData.blackColor
                                    : MyThemeData.whiteColor,
                              )),
                              hintText:
                                  AppLocalizations.of(context)!.description,
                              hintStyle: Theme.of(context).textTheme.headline4),
                          maxLines: 4,
                          minLines: 2,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .enterTheDescription;
                            }
                            return null;
                          },
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 18,
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
                const SizedBox(height: 18),
                Container(
                  margin: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      addTask();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(MyThemeData.primaryLight)),
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                )
              ],
            ),
          )),
    ]);
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      setState(() {
        selectedDate = chosenDate;
      });
    }
  }

  void addTask() {
    if (keyForm.currentState?.validate() == true) {
      Navigator.pop(context);
      Task task = Task(
          title: title,
          description: description,
          date: selectedDate.millisecondsSinceEpoch);
      addTaskFirebase(task).timeout(Duration(milliseconds: 500), onTimeout: () {
        print('task was added');

        setState(() {});
      });
    }
  }
}
