import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/models/session.dart';
import 'package:piperun/services/dialogs.dart';
import 'package:piperun/views/home_view_model.dart';

class HomeView extends StatefulWidget {
  static String routeName = 'home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showFecharAplicativo(context),
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text("PipeRun"))),
        body: Column(
          children: <Widget>[
            Center(child: Text("Bem-vindo!")),
          ],
        ),
        drawer: _buildDrawer(context),
      ),
    );
  }

  // menu esquerdo do app
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildAccountHeader(context),
          _buildBtnPipeline(),
          _buildBtnAtividades(),
          _buildBtnEmpresas(),
          _buildBtnPessoas(),
          _buildBtnDashboard(),
          _buildBtnLogout(context),
        ],
      ),
    );
  }

  // perfil do usuario
  UserAccountsDrawerHeader _buildAccountHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountEmail: Text(GetIt.instance<Session>().email),
      accountName: Text(GetIt.instance<Session>().name),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.blue : Colors.white,
        backgroundImage: GetIt.instance<Session>().avatar != null
            ? NetworkImage(GetIt.instance<Session>().avatar)
            : NetworkImage("https://app.pipe.run/img/user_64.png"),
      ),
    );
  }

  // botoes do Drawer
  ListTile _buildBtnPipeline() {
    return ListTile(
      title: Text(
        "Pipeline",
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: Icon(Icons.star),
    );
  }

  ListTile _buildBtnAtividades() {
    return ListTile(
      title: Text("Atividades"),
      trailing: Icon(Icons.apps, color: Colors.black),
      onTap: () => viewModel.btnAtividadesPressed(context),
    );
  }

  ListTile _buildBtnEmpresas() {
    return ListTile(
      title: Text(
        "Empresas",
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: Icon(Icons.accessibility),
    );
  }

  ListTile _buildBtnPessoas() {
    return ListTile(
      title: Text(
        "Pessoas",
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: Icon(Icons.people),
    );
  }

  ListTile _buildBtnDashboard() {
    return ListTile(
      title: Text(
        "Dashboard",
        style: TextStyle(color: Colors.grey.shade600),
      ),
      trailing: Icon(Icons.dashboard),
    );
  }

  ListTile _buildBtnLogout(BuildContext context) {
    return ListTile(
      title: Text("Logout"),
      trailing: Icon(Icons.exit_to_app, color: Colors.black),
      onTap: () => viewModel.btnLogoutPressed(context),
    );
  }
}
