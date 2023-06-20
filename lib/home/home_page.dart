import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/settings_details/settings_tab.dart';
import 'package:to_do_app/task_details/add_task_bottom_sheet.dart';
import 'package:to_do_app/task_details/tasks_tab.dart';
import 'package:to_do_app/theme_data.dart';

import '../providers/AppConfigProvider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePageName';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        title: Text(
          AppLocalizations.of(context)!.toDoList,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskBottomSheet();
        },
        backgroundColor: MyThemeData.primaryLight,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(30),
            side: BorderSide(
                width: 3,
                color: provider.appTheme == ThemeMode.dark
                    ? MyThemeData.blackColor
                    : MyThemeData.whiteColor)),
        child: const Icon(
          Icons.add_task,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: provider.appTheme == ThemeMode.dark
            ? MyThemeData.blackColor
            : MyThemeData.whiteColor,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.menu_book,
                  size: 30,
                ),
                label: AppLocalizations.of(context)?.tasksList),
            BottomNavigationBarItem(
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                ),
                label: AppLocalizations.of(context)?.settings)
          ],
          onTap: (i) {
            selectedIndex = i;
            setState(() {});
          },
          currentIndex: selectedIndex,
        ),
      ),
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsTab()];

  void addTaskBottomSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: false,
      enableDrag: false,
      context: context,
      builder: (context) => AddTaskBottomSheet(),
      shape: Border.all(width: 3, color: Theme.of(context).primaryColor),
    );
  }
}
