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

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();

    filterNameList = mapEvents(querySnapshot);
    eventList = filterNameList;

    filterNameList.sort((a, b) => a.eventDateTime.compareTo(b.eventDateTime));

    notifyListeners();
  }

  void getAllEventsFromFireStore(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).orderBy("eventDateTime").get();

    filterNameList = mapEvents(querySnapshot);

    notifyListeners();
  }

  void getFilteredEventFromFireStore(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .orderBy("eventDateTime")
            .where('eventName', isEqualTo: eventNameList[selectedIndex])
            .get();

    filterNameList = mapEvents(querySnapshot);

    notifyListeners();
  }

  void getFilteredEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();

    eventList = mapEvents(querySnapshot);

    filterNameList = eventList
        .where((event) => event.eventName == eventNameList[selectedIndex])
        .toList();

    filterNameList.sort((a, b) => a.eventDateTime.compareTo(b.eventDateTime));

    notifyListeners();
  }

  void updateIsFavoriteEvent(Event event, String uId) async {
    event.isFavorite = !event.isFavorite;

    // ✅ Update the list locally immediately
    favoriteEventList = eventList.where((e) => e.isFavorite == true).toList();
    notifyListeners();

    await FirebaseUtils.getEventCollection(uId).doc(event.id).update({
      "isFavorite": event.isFavorite,
    });

    ToastUtils.showToastMsg(msg: "Event Updated Successfully");
    selectedIndex == 0 ? getAllEvents(uId) : getFilteredEvents(uId);
    getAllFavoriteEvents(uId);
    notifyListeners();
  }

  void getAllFavoriteEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();

    // ✅ Use mapEvents() so id is always set
    eventList = mapEvents(querySnapshot);
    favoriteEventList = eventList
        .where((event) => event.isFavorite == true)
        .toList();

    favoriteEventList.sort((a, b) => a.eventDateTime.compareTo(b.eventDateTime));
    notifyListeners();
  }

  void getAllFavoriteEventsFromFireStore(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .orderBy("eventDateTime")
            .where('isFavorite', isEqualTo: true)
            .get();

    // Use mapEvents() so id is always set
    favoriteEventList = mapEvents(querySnapshot);
    notifyListeners();
  }

  void changeSelectedIndex(int newIndex, String uId) {
    selectedIndex = newIndex;

    if (selectedIndex == 0) {
      getAllEvents(uId);
    } else {
      getFilteredEventFromFireStore(uId);
    }
  }
}
