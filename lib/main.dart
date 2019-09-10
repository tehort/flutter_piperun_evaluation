import 'package:flutter/material.dart';
import 'package:piperun/_shared/dependency_injection.dart';
import 'package:piperun/views/activities_view.dart';
import 'package:piperun/views/activity_form_view.dart';
import 'package:piperun/views/home_view.dart';
import 'package:piperun/views/login_view.dart';

// registra os servicos para Injecao de Dependencia através de ServiceLocator
void main() {
  registerServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PipeRun',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      // seta um scaffold pai, para exibicao de SnackBars
      home: new Scaffold(body: MyHomePage(title: 'PipeRun')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// seta o login como rota inicial, e registra as outras rotas / views no app
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PipeRun',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: LoginView.routeName,
      routes: {
        LoginView.routeName: (_) => LoginView(),
        HomeView.routeName: (_) => HomeView(),
        ActivitiesView.routeName: (_) => ActivitiesView(),
        ActivityForm.routeName: (_) => ActivityForm(),
      },
    );
  }
}
