class Users {
  String id;
  String name;
  String email;

  Users({required this.id, required this.name, required this.email});

  static fromJson(Map<String, dynamic> json) {
    return Users(id: json['id'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}
