import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route/utils/app_styles.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/event_list_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/cutsom_text_form_feild.dart';
import '../home/widgets/event_item.dart';

class FavTab extends StatefulWidget {

  FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ✅ بنجيب الـ provider هنا صح
      eventListProvider = Provider.of<EventListProvider>(context, listen: false);
      eventListProvider.getAllFavoriteEvents();
    });
  }



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
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
              child:eventListProvider.favoriteEventList.isEmpty? Center(child: Text('No Events Found'),) :ListView.separated(
                itemBuilder: (context, index) => EventItem(event: eventListProvider.favoriteEventList[index]),
                separatorBuilder: (context, index) =>
                    SizedBox(height: height * 0.005),
                itemCount: eventListProvider.favoriteEventList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
