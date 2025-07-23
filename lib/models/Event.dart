class Event {
  String? id;
  String title;
  String category;
  String image;
  String description;
  String date;
  String time;
  bool isFavorite;

  Event({
    this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
    required this.category,
    required this.image,
    required this.date,
    required this.time,
  });

  // this method can change from json to our object model
  Event.fromJson(Map<String, dynamic> json):this(
    title : json['title'],
    description : json['description'],
    category : json['category'],
    image : json['image'],
    date : json['date'],
    id : json['id'],
    time : json['time'],
    isFavorite : json['isFavorite'],
  );

  //this method change from out object model to the json format to be stored in the firestore
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "isFavorite": isFavorite,
      "category": category,
      "image": image,
      "date": date,
      "time": time,
      "id": id,
      "favorite": isFavorite,
    };
  }
}
