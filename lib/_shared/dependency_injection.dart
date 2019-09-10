import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/services/api/api_service.dart';

void registerServices() {
  GetIt.instance.allowReassignment = true;

  GetIt.instance.registerSingleton<Dio>(
    Dio(
      new BaseOptions(
        baseUrl: ApiService.endpoint,
        connectTimeout: 20000,
        receiveTimeout: 20000,
        contentType: ContentType.parse("application/x-www-form-urlencoded"),
      ),
    ),
  );
}
