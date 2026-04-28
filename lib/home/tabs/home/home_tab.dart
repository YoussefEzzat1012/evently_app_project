import 'package:flutter/material.dart';
import 'package:route/home/tabs/home/widgets/event_item.dart';
import 'package:route/home/tabs/home/widgets/event_tab_item.dart';
import 'package:route/utils/app_styles.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List eventTabList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exception,
    ];


    List<String> eventImageList = [
      AppAssets.sportImage,
      AppAssets.birthdayImage,
      AppAssets.meetingImage,
      AppAssets.gamingImage,
      AppAssets.workshopImage,
      AppAssets.bookClubImage,
      AppAssets.holidayImage,
      AppAssets.exceptionImage,
    ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('welcom back', style: AppStyle.bold16White),
                Text('Rout Academy', style: AppStyle.bold24White),
              ],
            ),
            Spacer(),
            Image.asset(AppAssets.iconTheme),
            Container(
              margin: EdgeInsetsDirectional.only(start: width * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.whiteColor, width: 2),
              ),
              child: Text('EN', style: AppStyle.bold16Primary),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: AppColors.whiteColor),
                    Text('Cairo, Egypt', style: AppStyle.bold16White),
                  ],
                ),
                DefaultTabController(
                  length: eventTabList.length,
                  child: TabBar(
                    isScrollable: true,
                    labelPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    dividerColor: AppColors.transparentColor,
                    indicatorColor: AppColors.transparentColor,
                    tabs: eventTabList
                        .map(
                          (e) => EventTabItem(
                            selectedTextStyle: Theme.of(
                              context,
                            ).textTheme.headlineMedium!,
                            unSelectedTextStyle: AppStyle.medium16White,
                            bgSelectedColor: Theme.of(context).focusColor,
                            borderColor: Theme.of(context).focusColor,
                            eventName: e,
                            isSelected: selectedIndex == eventTabList.indexOf(e)
                                ? true
                                : false,
                          ),
                        )
                        .toList(),
                    onTap: (index) {
                      selectedIndex = index;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => EventItem(eventImageName: eventImageList[index],),
              separatorBuilder: (context, index) =>
                  SizedBox(height: height * 0.005),
              itemCount: eventImageList.length,
            ),
          ),
        ],
      ),
    );
  }
}
