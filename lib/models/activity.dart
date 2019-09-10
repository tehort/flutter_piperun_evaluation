import 'package:intl/intl.dart';

class Activity {
  int id;
  int account_id;
  String title;
  String description;
  int activity_type;
  DateTime start_at;
  DateTime end_at;
  int status;

  Activity();

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        account_id = json['account_id'],
        title = json['title'],
        description = json['description'],
        activity_type = json['activity_type'],
        start_at = json['start_at'] == null ? null : DateTime?.tryParse(json['start_at']),
        end_at = json['end_at'] == null ? null : DateTime?.tryParse(json['end_at']),
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_id': account_id,
        'title': title,
        'description': description,
        'activity_type': activity_type,
        'start_at': start_at == null ? null : DateFormat('yyyy-MM-dd HH:mm:ss').format(start_at),
        'end_at': end_at == null ? null : DateFormat('yyyy-MM-dd HH:mm:ss').format(end_at),
        'status': status,
      };
}
