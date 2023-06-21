import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/theme_data.dart';

import '../firebase_funs.dart';
import '../model/firebase_task.dart';
import '../providers/AppConfigProvider.dart';
import 'edit_task.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
        margin: const EdgeInsets.all(12),
        child: Slidable(
          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const StretchMotion(),
            extentRatio: 0.35,
            // A pane can dismiss the Slidable.
            //openThreshold: 0.7,
            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (context) {
                  deleteTaskFirebase(widget.task)
                      .timeout(Duration(milliseconds: 300));
                },
                backgroundColor: MyThemeData.redColor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: AppLocalizations.of(context)!.delete,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
            ],
          ),

          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.headline1!.color,
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.all(12),
              //margin: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    width: 6,
                    decoration: BoxDecoration(
                        color: widget.task.isDone == true
                            ? MyThemeData.greenColor
                            : MyThemeData.primaryLight,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EditTask.routeName,
                          arguments: TaskDetailsArgs(task: widget.task));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Text(widget.task.title,
                              style: widget.task.isDone == false
                                  ? Theme.of(context).textTheme.headline2
                                  : Theme.of(context).textTheme.subtitle2),
                          Text(
                            widget.task.description,
                            style: Theme.of(context).textTheme.headline3,
                          )
                        ],
                      ),
                    ),
                  )),
                  SizedBox(
                    //height: 30,
                    width: 115,
                    child: InkWell(
                      onTap: () {
                        doneTest(widget.task);

                        /// TODO
                        //widget.task.isDone = true;
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 18),
                          decoration: BoxDecoration(
                              color: widget.task.isDone == true
                                  ? Colors.transparent
                                  : MyThemeData.primaryLight,
                              borderRadius: BorderRadius.circular(30)),
                          child: widget.task.isDone == false
                              ? const Icon(Icons.check_rounded,
                                  size: 35, color: Colors.white)
                              : Text(
                                  AppLocalizations.of(context)!.done,
                                  style: Theme.of(context).textTheme.subtitle2,
                                )),
                    ),
                  )
                ],
              )),
        ));
  }

  doneTest(Task task) {
    task.isDone = true;
    updateTaskIsDoneFirebase(task);
    setState(() {});
  }
}

class TaskDetailsArgs {
  Task task;

  TaskDetailsArgs({required this.task});
}
