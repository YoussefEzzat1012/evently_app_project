import 'package:flutter/material.dart';
import 'package:route/home/add_event/widgets/date_or_time_widget.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../tabs/home/widgets/event_tab_item.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/cutsom_text_form_feild.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  String? formatDate;
  TimeOfDay? selectedTime;
  String? formatTime;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var descriptionController = TextEditingController();


    List eventTabList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
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
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(AppLocalizations.of(context)!.createEvent, style: AppStyle.bold20Primary),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(eventImageList[selectedIndex]),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.09,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: EventTabItem(
                            borderColor: AppColors.primaryColor,
                            selectedTextStyle: Theme
                                .of(
                              context,
                            )
                                .textTheme
                                .titleMedium!,
                            unSelectedTextStyle: AppStyle.bold16Primary,
                            bgSelectedColor: AppColors.primaryColor,
                            eventName: eventTabList[index],
                            isSelected: selectedIndex == index,
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * 0.02),
                    itemCount: eventTabList.length,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall,
                ),
                SizedBox(height: height * 0.01),
                CutsomTextFormFeild(
                  controller: titleController,
                  prefixIcon: Image.asset(
                    AppAssets.editIcon,
                    color: Theme
                        .of(context)
                        .splashColor,
                  ),
                  hintText: AppLocalizations.of(context)!.eventTitle,
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  borderSideColor: Theme
                      .of(context)
                      .splashColor,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "please enter event title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall,
                ),
                SizedBox(height: height * 0.01),
                CutsomTextFormFeild(
                  maxLines: 4,
                  obSecureText: false,
                  controller: descriptionController,
                  hintText: AppLocalizations.of(context)!.eventDescription,
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  borderSideColor: Theme
                      .of(context)
                      .splashColor,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "please enter event description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                DateOrTimeWidget(
                  icon: Icons.date_range,
                  eventDateOrTime: AppLocalizations.of(context)!.eventDate,
                  chooseDateText: selectedDate == null ? AppLocalizations.of(
                      context)!.chooseDate : formatDate!,
                  //"${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  onChooseDateOrTime: chooseDate,
                ),
                SizedBox(height: height * 0.01),
                DateOrTimeWidget(
                  icon: Icons.timer,
                  eventDateOrTime: AppLocalizations.of(context)!.eventTime,
                  chooseDateText: selectedTime == null ? AppLocalizations.of(context)!.chooseTime : formatTime!,
                  onChooseDateOrTime: chooseTime,
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                    onPressed: () {},
                    text: "",
                    backGroundColor: AppColors.transparentColor,
                    borderColor: AppColors.primaryColor,
                    hasIcon: true,
                    childIconWidget: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.04,
                            vertical: height * 0.02,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: Image.asset(AppAssets.iconLocation, color: Theme
                              .of(context)
                              .dividerColor),
                        ),
                        SizedBox(width: width * 0.04),
                        Text(AppLocalizations.of(context)!.chooseEventLocation,
                            style: AppStyle.bold20Primary),
                        Spacer(),
                        Padding(
                          padding: EdgeInsetsDirectional.only(end: width * 0.04),
                          child: Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColors.primaryColor,),
                        )
                      ],
                    )
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                    onPressed: addEvent,
                    text: "",
                    backGroundColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    hasIcon: true,
                    childIconWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.addEvent,
                            style: AppStyle.bold20White),
                      ],
                    )
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    selectedDate = chooseDate;
    if(selectedDate != null) {
      formatDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
    }
    setState(() {

    });
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if(selectedTime != null) {
      formatTime = selectedTime!.format(context);
    }
    setState(() {

    });
  }

  void addEvent() {
    if(formKey.currentState!.validate()) {
      //todo: add event
    }
  }

}
