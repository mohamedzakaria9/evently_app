import 'package:intl/intl.dart';

class Event {
  String? id;
  String image;
  String category;
  String title;
  String description;
  DateTime date;
  var time;
  bool isFavorite;

  Event({
    this.id,
    required this.image,
    required this.category,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isFavorite = false,
  });

  static fromJson(Map<String, dynamic> json) {
    //print("this is the date from the fromJson method: ${json['date']}");
    return Event(
      id: json['id'],
      image: json['image'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      date: parseFlexibleDate(json['date']),
      time: json['time'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    //print("this is the date from the toJson method: ${DateFormat.yMMMd().format(date)}");
    return {
      "id": id,
      "image": image,
      "category": category,
      "title": title,
      "description": description,
      "date": DateFormat.yMMMd().format(date),
      "time": time,
      "isFavorite": isFavorite
    };
  }
  static DateTime parseFlexibleDate(String input) {
    try {
      return DateFormat('MMMM d, y', 'en_US').parseStrict(input);
    } catch (_) {
      return DateFormat('MMM d, y', 'en_US').parseStrict(input);
    }
  }
}
