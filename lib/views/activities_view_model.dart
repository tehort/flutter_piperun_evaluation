import 'package:flutter/material.dart';
import 'package:piperun/models/activity.dart';
import 'package:piperun/services/api/activities_service.dart';
import 'package:piperun/services/dialogs.dart';
import 'package:piperun/views/activity_form_view.dart';

class ActivitiesViewModel with ChangeNotifier {
  // controle de estado da View
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  DateTime _dataInicial;
  DateTime _dataFinal;

  List<Activity> _lstActivities;
  List<Activity> get lstActivities => _lstActivities;

  var activityService = ActivitiesService();

  ActivitiesViewModel() {
    _loadData();
  }

  void reloadData([bool resetData]) {
    isLoading = true;
    if (resetData == true) {
      _dataInicial = null;
      _dataFinal = null;
    }
    _loadData();
  }

  Future _loadData() async {
    _lstActivities = await activityService.fetchActivities(_dataInicial, _dataFinal);
    isLoading = false;
  }

  // exibe um aviso e o datePicker para o usuario selecionar a data inicial e data final do filtro
  void fabPesquisaPressed(BuildContext context) async {
    await showAlertDialogData(context, "Data", "Selecione a data inicial:");
    _dataInicial = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 90)),
      lastDate: DateTime.now().add(Duration(days: 90)),
    );

    await showAlertDialogData(context, "Data", "Selecione a data final:");
    _dataFinal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 90)),
      lastDate: DateTime.now().add(Duration(days: 90)),
    );

    reloadData();
  }

  // no caso de adicionar uma nova atividade, faz o recarregamento da tela, zerando as datas do filtro
  void fabAdicionaPressed(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityForm())).then(
      (onValue) {
        this.reloadData(true);
      },
    );
  }

  void btnEditarPressed(BuildContext context, Activity item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActivityForm(activity: item)),
    ).then(
      (onValue) {
        this.reloadData();
      },
    );
  }

  //realiza a conclusao do item, e o update
  void btnConcluirPressed(BuildContext context, Activity item) async {
    item.end_at;
    item.status = 2;

    await activityService.updateActivity(item).then(
      (isSuccess) {
        this.reloadData();
      },
    ).catchError(
      (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Erro no servidor")));
        print(e.toString());
      },
    );
  }

  // deleta a atividade
  void btnDeletePressed(BuildContext context, Activity item) async {
    await activityService.deleteActivity(item).then(
      (isSuccess) {
        this.reloadData();
      },
    ).catchError(
      (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Erro no servidor")));
      },
    );
  }
}
