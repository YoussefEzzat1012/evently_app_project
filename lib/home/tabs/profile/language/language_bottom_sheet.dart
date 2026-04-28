import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_language_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         InkWell(
           onTap: (){
             //todo: change language to english
             languageProvider.changeLanguage('en');
           },
           child: languageProvider.appLanguage == 'en' ?
               getSelectedItemWidget(language: AppLocalizations.of(context)!.english) :
               getUnSelectedItemWidget(language: AppLocalizations.of(context)!.english),
         ),
          InkWell(
            onTap: (){
              //todo: change language to arabic
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar' ?
            getSelectedItemWidget(language: AppLocalizations.of(context)!.arabic) :
            getUnSelectedItemWidget(language: AppLocalizations.of(context)!.arabic),
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
