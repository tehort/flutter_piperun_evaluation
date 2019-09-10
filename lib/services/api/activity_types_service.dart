import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/models/activity_type.dart';

class ActivityTypesService {
  final activityRoute = '/activityTypes';

  Future<List<ActivityType>> fetchActivityTypes() async {
    var response = await GetIt.instance<Dio>().get(
      activityRoute,
    );

    if (response.statusCode == 200) {
      return (response.data['data'] as List<dynamic>).map((e) => new ActivityType.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
