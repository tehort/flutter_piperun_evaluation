class ActivityType {
  int id;
  String name;

  ActivityType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
