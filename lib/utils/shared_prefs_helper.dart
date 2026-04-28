import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsKey {
  static const String mostRecentKey = "most_recent";
}

void saveLastSuraIndex(int suraIndex) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> mostRecent =
      prefs.getStringList(SharedPrefsKey.mostRecentKey) ?? [];
  if (mostRecent.contains("$suraIndex")) {
    mostRecent.remove("$suraIndex");
  }
  mostRecent.insert(0, '$suraIndex');

  if (mostRecent.length > 5) {
    //mostRecent.removeLast();
    mostRecent = mostRecent.sublist(0, 5);
  }
  await prefs.setStringList(SharedPrefsKey.mostRecentKey, mostRecent);
}
