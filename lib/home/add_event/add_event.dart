import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:route/home/add_event/widgets/date_or_time_widget.dart';
import 'package:route/providers/event_list_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../models/event.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/firebase_utils.dart';
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
  DateTime? selectedDate;
  String? formatDate;
  TimeOfDay? selectedTime;
  String? formatTime;
  String eventName = "";
  String eventImage = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  late EventListProvider eventListProvider;
  late List<String> eventListName;
  List<String> tabsName = [];

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
    eventListProvider = Provider.of<EventListProvider>(context);
    eventListName = eventListProvider.getEventNameList(context);
     tabsName = eventListProvider.eventNameList
        .where((e) => e != AppLocalizations.of(context)!.all)
        .toList();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.createEvent,
          style: AppStyle.bold20Primary,
        ),
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
                  child: Image.asset(eventImageList[eventListProvider.selectedIndex]),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.09,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        eventListProvider.changeSelectedIndex(index);
                      },
                      child: EventTabItem(
                        borderColor: AppColors.primaryColor,
                        selectedTextStyle: Theme.of(
                          context,
                        ).textTheme.titleMedium!,
                        unSelectedTextStyle: AppStyle.bold16Primary,
                        bgSelectedColor: AppColors.primaryColor,
                        eventName:  tabsName[index],
                        isSelected: eventListProvider.selectedIndex == index,
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * 0.02),
                    itemCount: eventListProvider.eventNameList.length - 1,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: height * 0.01),
                CutsomTextFormFeild(
                  controller: titleController,
                  prefixIcon: Image.asset(
                    AppAssets.editIcon,
                    color: Theme.of(context).splashColor,
                  ),
                  hintText: AppLocalizations.of(context)!.eventTitle,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  borderSideColor: Theme.of(context).splashColor,
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
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: height * 0.01),
                CutsomTextFormFeild(
                  maxLines: 4,
                  obSecureText: false,
                  controller: descriptionController,
                  hintText: AppLocalizations.of(context)!.eventDescription,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  borderSideColor: Theme.of(context).splashColor,
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
                  chooseDateText: selectedDate == null
                      ? AppLocalizations.of(context)!.chooseDate
                      : formatDate!,
                  //"${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  onChooseDateOrTime: chooseDate,
                ),
                SizedBox(height: height * 0.01),
                DateOrTimeWidget(
                  icon: Icons.timer,
                  eventDateOrTime: AppLocalizations.of(context)!.eventTime,
                  chooseDateText: selectedTime == null
                      ? AppLocalizations.of(context)!.chooseTime
                      : formatTime!,
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
                        margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.02,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primaryColor,
                        ),
                        child: Image.asset(
                          AppAssets.iconLocation,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Text(
                        AppLocalizations.of(context)!.chooseEventLocation,
                        style: AppStyle.bold20Primary,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: width * 0.04),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
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
                      Text(
                        AppLocalizations.of(context)!.addEvent,
                        style: AppStyle.bold20White,
                      ),
                    ],
                  ),
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
    if (selectedDate != null) {
      formatDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
    }
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    if (selectedTime != null) {
      formatTime = selectedTime!.format(context);
    }
    setState(() {});
  }

  void addEvent() {
    if (formKey.currentState!.validate()) {
      //todo: add event
      Event event = Event(
        description: descriptionController.text,
        title: titleController.text,
        eventName: eventListName[eventListProvider.selectedIndex + 1],
        eventImage: eventImageList[eventListProvider.selectedIndex],
        eventDateTime: selectedDate!,
        eventTime: formatTime!,
      );
      FirebaseUtils.addEventToFirebase(event).timeout(
        Duration(seconds: 1),
        onTimeout: () {
          //alert dialog - toast - snack bar
          Fluttertoast.showToast(
            msg: "event added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,);
          Navigator.pop(context);
        },
      );
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventListProvider.getAllEvents();
  }
}
