import 'package:flutter/material.dart';
import 'package:piperun/views/activities_view.dart';
import 'package:piperun/views/login_view.dart';

class HomeViewModel {
  void btnAtividadesPressed(BuildContext context) async {
    Navigator.of(context).pop();
    await Navigator.of(context).pushNamed(ActivitiesView.routeName);
  }

  // remove todas as abas, e seta a loginview como inicial
  void btnLogoutPressed(BuildContext context) async {
    await Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (_) => false);
  }
}
