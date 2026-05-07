import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route/home/tabs/home/widgets/event_item.dart';
import 'package:route/home/tabs/home/widgets/event_tab_item.dart';
import 'package:route/providers/event_list_provider.dart';
import 'package:route/utils/app_styles.dart';
import 'package:route/utils/firebase_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/event.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late EventListProvider eventListProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventListProvider.getAllEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);
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

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('مرحبا✨', style: AppStyle.bold20White),
                Text('يوسف عزت', style: AppStyle.bold24White),
                SizedBox(height: height * 0.01)
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
                    SizedBox(width: width * 0.02,),
                    Icon(Icons.location_on, color: AppColors.whiteColor),
                    Text('القاهرة, مصر', style: AppStyle.bold16White),
                  ],
                ),
                DefaultTabController(
                  length: eventListProvider.eventNameList.length,
                  child: TabBar(
                    isScrollable: true,
                    labelPadding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.start,
                    dividerColor: AppColors.transparentColor,
                    indicatorColor: AppColors.transparentColor,
                    tabs: eventListProvider.eventNameList
                        .map(
                          (e) => EventTabItem(
                            selectedTextStyle: Theme.of(
                              context,
                            ).textTheme.headlineMedium!,
                            unSelectedTextStyle: AppStyle.medium16White,
                            bgSelectedColor: Theme.of(context).focusColor,
                            borderColor: Theme.of(context).focusColor,
                            eventName: e,
                            isSelected:
                                eventListProvider.selectedIndex ==
                                    eventListProvider.eventNameList.indexOf(e)
                                ? true
                                : false,
                          ),
                        )
                        .toList(),
                    onTap: (index) {
                      eventListProvider.changeSelectedIndex(index);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: eventListProvider.filterNameList.isEmpty
                ? Center(
                    child: Text(
                      "no events found",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) =>
                        EventItem(event: eventListProvider.filterNameList[index]),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * 0.005),
                    itemCount: eventListProvider.filterNameList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
