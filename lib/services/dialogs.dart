import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// alguns dialogs utilizados no app

Future<bool> showFecharAplicativo(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Fechar aplicativo?', style: new TextStyle(color: Colors.black, fontSize: 20.0)),
      content: new Text('Você tem certeza que deseja fechar o aplicativo?'),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          child: new Text('Sim', style: new TextStyle(fontSize: 18.0)),
        ),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: new Text('Cancelar', style: new TextStyle(fontSize: 18.0)),
        ),
      ],
    ),
  );
}

Future<bool> showAlertDialogData(BuildContext context, String title, String text) {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text(title, style: new TextStyle(color: Colors.black, fontSize: 20.0)),
      content: new Text(text),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: new Text('Ok', style: new TextStyle(fontSize: 18.0)),
        ),
      ],
    ),
  );
}
