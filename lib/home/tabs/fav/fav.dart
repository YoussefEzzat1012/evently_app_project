import 'package:flutter/material.dart';
import 'package:route/utils/app_styles.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/cutsom_text_form_feild.dart';
import '../home/widgets/event_item.dart';

class FavTab extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  FavTab({super.key});

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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          children: [
            CutsomTextFormFeild(
              borderSideColor: AppColors.primaryColor,
              hintText: AppLocalizations.of(context)!.searchEvent,
              controller: searchController,
              keyboardType: TextInputType.text,
              hintStyle: AppStyle.bold14Primary,
              prefixIcon: Image.asset(AppAssets.iconSearch),
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
      ),
    );
  }
}
