import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/models/session.dart';
import 'package:piperun/services/api/auth_service.dart';
import 'package:piperun/views/home_view.dart';

class LoginViewModel with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // determinam qual o proximo componente a receber o foco
  final emailInputFocusNode = new FocusNode();
  final passwordInputFocusNode = new FocusNode();

  // controle dos textfields
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  final loginService = new LoginService();

  LoginViewModel() {
    // se nao for release mode, entao usa o login e senha
    if (!kReleaseMode) {
      emailController.text = "tybusch.douglas@gmail.com";
      passwordController.text = "tybusch666";
    }
  }

  void btnLoginPressed(BuildContext context) async {
    try {
      isLoading = true;
      if (emailController.text == '') {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Utilize um e-mail válido.")));
      } else if (passwordController.text == '') {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Utilize uma senha válida.")));
      } else {
        await loginService.fetchTokenFromAPI(emailController.text, passwordController.text).then(
          (session) async {
            if (session != null) {
              GetIt.instance.registerSingleton<Session>(session);
              await Navigator.pushNamedAndRemoveUntil(context, HomeView.routeName, (_) => false);
            }
          },
        ).catchError((e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Login inválido")));
          e.print(e.toString());
        });
      }
    } finally {
      isLoading = false;
    }
  }
}
