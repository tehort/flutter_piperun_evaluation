import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/models/session.dart';

class LoginService {
  String loginRoute = '/auth';

  Future<Session> fetchTokenFromAPI(String email, String password) async {
    var response = await GetIt.instance<Dio>().post(
      loginRoute,
      data: {"email": email, "password": password},
    );

    if (response.statusCode == 200) {
      var session = Session.fromJson(response.data['data']['me'] as Map<String, dynamic>);

      // seta o token para todos chamados através do DIO
      GetIt.instance<Dio>().options.headers["Token"] = session.token;
      print(session.token);
      return session;
    } else {
      return null;
    }
  }
}
