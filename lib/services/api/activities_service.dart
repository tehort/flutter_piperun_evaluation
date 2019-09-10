import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/models/activity.dart';

class ActivitiesService {
  String activityRoute = '/activities';

  Future<List<Activity>> fetchActivities([DateTime start_at_start, DateTime start_at_end]) async {
    // parametros opcionais para filtragem por data na pesquisa de atividades
    var params = Map<String, dynamic>();
    start_at_start != null ? params.putIfAbsent("start_at_start", () => start_at_start) : null;
    start_at_end != null ? params.putIfAbsent("start_at_end", () => start_at_end) : null;

    var response = await GetIt.instance<Dio>().get(
      activityRoute,
      queryParameters: params,
    );

    if (response.statusCode == 200) {
      return (response.data['data'] as List<dynamic>).map((e) => new Activity.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<bool> addActivity(Activity obj) async {
    GetIt.instance<Dio>().options.contentType = ContentType.parse("application/json");
    var response = await GetIt.instance<Dio>().post(
      activityRoute,
      data: json.encode(obj.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateActivity(Activity obj) async {
    GetIt.instance<Dio>().options.contentType = ContentType.parse("application/json");
    var response = await GetIt.instance<Dio>().put(
      activityRoute + '/' + obj.id.toString(),
      data: json.encode(obj.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteActivity(Activity obj) async {
    var response = await GetIt.instance<Dio>().delete(
      activityRoute + '/' + obj.id.toString(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
