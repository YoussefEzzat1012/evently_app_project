
class Event{
  static const String collectionName = "events";
  String id;
  String description;
  String title;
  String eventName;
  String eventImage;
  bool isFavorite;
  DateTime eventDateTime;
  String eventTime;

  Event({
    this.id = "",
    required this.description,
    required this.title,
    required this.eventName,
    required this.eventImage,
    this.isFavorite = false,
    required this.eventDateTime,
    required this.eventTime,
  });

  Event.fromFireStore(Map<String, dynamic> data) : this(
    description: data["description"],
    title: data["title"],
    eventName: data["eventName"],
    eventDateTime: DateTime.fromMillisecondsSinceEpoch(data["eventDateTime"]),
    eventImage: data["eventImage"],
    eventTime: data["eventTime"],
    isFavorite: data["isFavorite"],
  );

  Map<String, dynamic> toFireStore() {
    return {
      "description": description,
      "title": title,
      "eventName": eventName,
      "eventImage": eventImage,
      "isFavorite": isFavorite,
      "eventDateTime": eventDateTime.millisecondsSinceEpoch,
      "eventTime": eventTime,
    };
  }
  }
