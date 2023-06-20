import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/task_details/task_item.dart';

import '../providers/AppConfigProvider.dart';
import '../theme_data.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<AppConfigProvider>(context);
    listProvider.addTaskFromFirebase();
    return Column(
      children: [
        /*EasyDateTimeLine(

            onDateChange: (date) {
              listProvider.selectedDate = date;
            },
            activeColor: MyThemeData.primaryLight,
            initialDate: listProvider.selectedDate),
        SizedBox(height: 15),

         */
        CalendarTimeline(
          //shrink: true,
          initialDate: listProvider.selectedDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            listProvider.selectedDate = date;
          },
          leftMargin: 20,
          monthColor: Theme.of(context).textTheme.headline5!.color,
          dayColor: Theme.of(context).textTheme.headline5!.color,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: MyThemeData.primaryLight,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return TaskItem(
              task: AppConfigProvider.taskList[index],
            );
          },
          itemCount: AppConfigProvider.taskList.length,
        ))
      ],
    );
  }
}
