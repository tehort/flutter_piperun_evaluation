import 'dart:core';

class Session {
  Session();

  int id;
  int account_id;
  DateTime created_at;
  DateTime last_login_at;
  int hash;
  String email;
  String name;
  int active;
  String avatar;
  DateTime birth_day;
  String cellphone;
  String cpf;
  String gender;
  int only_yours_deals;
  int pipeline_id;
  int pipeline_view;
  String selected_email;
  int session_lifetime;
  String signature;
  String tellphone;
  String url_public_calendar;
  String token;

  Session.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        account_id = json['account_id'],
        created_at = DateTime.parse(json['created_at']),
        last_login_at = DateTime.parse(json['last_login_at']),
        hash = int.tryParse(json['hash']),
        email = json['email'],
        name = json['name'],
        active = json['active'],
        avatar = json['avatar'],
        birth_day = json['birth_day'] == null ? null : DateTime?.tryParse(json['birth_day']),
        cellphone = json['cellphone'],
        cpf = json['cpf'],
        gender = json['gender'],
        only_yours_deals = json['only_yours_deals'],
        pipeline_id = json['pipeline_id'],
        pipeline_view = json['pipeline_view'],
        selected_email = json['selected_email'],
        session_lifetime = json['session_lifetime'],
        signature = json['signature'],
        tellphone = json['tellphone'],
        url_public_calendar = json['url_public_calendar'],
        token = json['token'];
}
