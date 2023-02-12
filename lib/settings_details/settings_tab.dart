import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/settings_details/theme_bottom_sheet.dart';
import 'package:to_do_app/theme_data.dart';

import '../providers/AppConfigProvider.dart';
import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Text(AppLocalizations.of(context)!.settings,
                  style: Theme.of(context).textTheme.headline3,),
            ),
            const SizedBox(height: 25),
            Text(
              '${AppLocalizations.of(context)!.language} :',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: MyThemeData.primaryLight),
                  color: Theme.of(context).textTheme.headline1!.color,
                  borderRadius: BorderRadius.circular(25)),
              child: InkWell(
                onTap: () {
                  showLanguageBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      size: 24,
                      color: Theme.of(context).textTheme.headline2?.color,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Divider(
              height: 5,
              color: MyThemeData.whiteColor,
            ),
            const SizedBox(height: 15),
            Text(
              '${AppLocalizations.of(context)!.theme} :',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: MyThemeData.primaryLight),
                  color: Theme.of(context).textTheme.headline1?.color,
                  borderRadius: BorderRadius.circular(25)),
              child: InkWell(
                onTap: () {
                  showThemeBottomSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.appTheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      size: 24,
                      color: Theme.of(context).textTheme.headline2?.color,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Divider(
              height: 5,
              color: MyThemeData.whiteColor,
            ),
          ],
        ));
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageBottomSheet();
      },
      shape: Border.all(width: 5, color: Theme.of(context).primaryColor),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ThemeBottomSheet();
      },
      shape: Border.all(
          width: 5,
          color: Theme.of(context).primaryColor
      ),
    );
  }
}
