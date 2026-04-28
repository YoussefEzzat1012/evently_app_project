import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:route/home/tabs/profile/theme/theme_bottom_sheet.dart';
import 'package:route/utils/app_colors.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_styles.dart';
import '../../widgets/custom_elevated_button.dart';
import 'language/language_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.18,
        title: Row(
          children: [
            Image.asset(AppAssets.routeImage),
            SizedBox(width: width * 0.04,),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Route Academy', style: AppStyle.bold24White,),
                    Text('RouteMoSalah74@gmail.com',
                      style: AppStyle.regular20White,
                      softWrap: true,
                      maxLines: 2,)
                  ]
              ),
            )
          ],
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Text(appLanguageProvider.appLanguage == "en" ?AppLocalizations.of(
              context)!.language: AppLocalizations.of(context)!.arabic,
      style: Theme
          .of(context)
          .textTheme
          .headlineLarge,
    ),
    InkWell(
    onTap: (){
    showLanguageBottomSheet();
    },
    child: Container(
    margin: EdgeInsets.symmetric(
    vertical: height * 0.02,
    ),
    padding: EdgeInsets.symmetric(
    horizontal: width * 0.02,
    vertical: height * 0.01,
    ),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
    color: AppColors.primaryColor,
    width: 2
    ),
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(AppLocalizations.of(context)!.language,
    style: AppStyle.bold20Primary,
    ),
    Icon(Icons.arrow_drop_down, color: AppColors.primaryColor,)

    ],
    ),
    ),
    ),
    SizedBox(height: height * 0.02,),
    Text(AppLocalizations.of(context)!.theme,
    style: Theme.of(context).textTheme.headlineLarge,
    ),
    InkWell(
    onTap: (){
    showThemeBottomSheet();
    },
    child: Container(
    margin: EdgeInsets.symmetric(
    vertical: height * 0.02,
    ),
    padding: EdgeInsets.symmetric(
    horizontal: width * 0.02,
    vertical: height * 0.01,
    ),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
    color: AppColors.primaryColor,
    width: 2
    ),
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(appThemeProvider.isDarkMode() ?AppLocalizations.of(context)!.dark: AppLocalizations.of(context)!.light,
    style: AppStyle.bold20Primary,
    ),
    Icon(Icons.arrow_drop_down, color: AppColors.primaryColor,)

    ],
    ),
    ),
    ),
    Spacer(),
    Container(
    width: double.infinity,
    child: CustomElevatedButton(
    onPressed: () {},
    backGroundColor: AppColors.redColor,
    text: "",
    hasIcon: true,
    childIconWidget: Row(
    children: [
    Padding(
      padding:  EdgeInsetsDirectional.only(start: width * 0.04),
      child: Icon(Bootstrap.box_arrow_right, color: AppColors.whiteColor, size: width * 0.07,),
    ),
    SizedBox(width: width * 0.04),
    Text(AppLocalizations.of(context)!.logout, style: AppStyle.bold20White),
    ]),
    ),
    ),
    SizedBox(height: height * 0.02,),
    ],
    ),
    ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
