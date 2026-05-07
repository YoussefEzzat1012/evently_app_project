import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:route/utils/toast_utils.dart';

import '../l10n/app_localizations.dart';
import '../models/event.dart';
import '../utils/firebase_utils.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<String> eventNameList = [];
  List<Event> filterNameList = [];
  List<Event> favoriteEventList = [];
  int selectedIndex = 0;

  List<Event> mapEvents(QuerySnapshot<Event> snapshot) {
    return snapshot.docs.map((doc) {
      final event = doc.data();
      event.id = doc.id;
      return event;
    }).toList();
  }

  List<String> getEventNameList(BuildContext context) {
    return eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exception,
    ];
  }

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection().get();

    filterNameList = mapEvents(querySnapshot);
    eventList = filterNameList;

    filterNameList.sort((a, b) =>
        a.eventDateTime.compareTo(b.eventDateTime));

    notifyListeners();
  }

  void getAllEventsFromFireStore() async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection()
        .orderBy("eventDateTime")
        .get();

    filterNameList = mapEvents(querySnapshot);

    notifyListeners();
  }

  void getFilteredEventFromFireStore() async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection()
        .orderBy("eventDateTime")
        .where('eventName', isEqualTo: eventNameList[selectedIndex])
        .get();

    filterNameList = mapEvents(querySnapshot);

    notifyListeners();
  }

  void getFilteredEvents() async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection().get();

    eventList = mapEvents(querySnapshot);

    filterNameList = eventList
        .where((event) =>
    event.eventName == eventNameList[selectedIndex])
        .toList();

    filterNameList.sort((a, b) =>
        a.eventDateTime.compareTo(b.eventDateTime));

    notifyListeners();
  }

  void updateIsFavoriteEvent(Event event) async {
    event.isFavorite = !event.isFavorite;

    // ✅ Update the list locally immediately
    favoriteEventList = eventList.where((e) => e.isFavorite == true).toList();
    notifyListeners();

    await FirebaseUtils.getEventCollection()
        .doc(event.id)
        .update({"isFavorite": event.isFavorite});

    ToastUtils.showToastMsg(msg: "Event Updated Successfully");
    selectedIndex == 0 ? getAllEvents() : getFilteredEvents();
    getAllFavoriteEvents();
    notifyListeners();
  }

  void getAllFavoriteEvents() async {
    QuerySnapshot<Event> querySnapshot =
    await FirebaseUtils.getEventCollection().get();

    // ✅ Use mapEvents() so id is always set
    eventList = mapEvents(querySnapshot);
    favoriteEventList = eventList.where((event) => event.isFavorite == true).toList();

    print(favoriteEventList.length);
    notifyListeners();
  }

  void changeSelectedIndex(int newIndex) {
    selectedIndex = newIndex;

    if (selectedIndex == 0) {
      getAllEvents();
    } else {
      getFilteredEventFromFireStore();
    }
  }
}