
import 'package:flutter/material.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
class EventItem extends StatelessWidget {
  final String eventImageName;
  EventItem({super.key, required this.eventImageName});


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.25,
      margin: EdgeInsets.symmetric(
        vertical: height * 0.01,
        horizontal: width * 0.02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 2
        ),
        image: DecorationImage(image: AssetImage(eventImageName), fit: BoxFit.fill)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: height * 0.01,
            ),
            margin: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.02,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).dividerColor,
            ),
            child: Column(
              children: [
                Text('21', style: AppStyle.bold20Primary,),
                Text('Oct', style: AppStyle.bold14Primary,),
              ]
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.01,
              horizontal: width * 0.02,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * 0.01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).dividerColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(child: Text("This is a birthday party", style: Theme.of(context).textTheme.headlineMedium,)),
               Image.asset(AppAssets.favIcon, color: AppColors.primaryColor,)
        ]
      )
          ),
        ],
      ),
    );
  }
}
