import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         InkWell(
           onTap: (){
             //todo: change theme to dark
             appThemeProvider.changeThemeMode(ThemeMode.dark);
           },
           child: appThemeProvider.isDarkMode() ?
               getSelectedItemWidget(language: AppLocalizations.of(context)!.dark) :
               getUnSelectedItemWidget(language: AppLocalizations.of(context)!.dark),
         ),
          InkWell(
            onTap: (){
              //todo: change theme to light
              appThemeProvider.changeThemeMode(ThemeMode.light);
            },
            child: !appThemeProvider.isDarkMode() ?
            getSelectedItemWidget(language: AppLocalizations.of(context)!.light) :
            getUnSelectedItemWidget(language: AppLocalizations.of(context)!.light),
          )
        ],
      ),
    );
  }

  Widget getSelectedItemWidget({required String language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: AppStyle.bold16Primary,),
        Icon(Icons.check, color: AppColors.primaryColor,)
      ],
    );
  }
  
  Widget getUnSelectedItemWidget({required String language}) {
    return Text(language, style: AppStyle.bold16Black,);
  }
}
