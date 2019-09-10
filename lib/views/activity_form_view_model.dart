import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/models/activity.dart';
import 'package:piperun/models/activity_type.dart';
import 'package:piperun/models/session.dart';
import 'package:piperun/services/api/activities_service.dart';
import 'package:piperun/services/api/activity_types_service.dart';
import 'package:piperun/views/activity_form_view.dart';

class ActivityFormViewModel with ChangeNotifier {
  // isLoad deve ser modificado apenas pelo setter, visto que afeta o estado da aplicação, e precisa notificar a View
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<ActivityType> _activityTypes;
  List<ActivityType> get getActivityTypes => _activityTypes;

  var activityService = ActivitiesService();
  var activityTypesService = ActivityTypesService();

  TextEditingController controllerTitle = TextEditingController();
  bool isTitleValid;

  int dropdownTypeValue;
  int dropdownStatusValue;
  String dropdownResponsibleValue = GetIt.instance<Session>().name;

  ActivityFormViewModel() {
    _loadActivityType();
  }

  Future _loadActivityType() async {
    _activityTypes = await activityTypesService.fetchActivityTypes();
    isLoading = false;
  }

  // controla o estado após o chamado da api
  Future addActivity(Activity activity) async {
    try {
      isLoading = true;
      return await activityService.addActivity(activity);
    } finally {
      isLoading = false;
    }
  }

  // controla o estado após o chamado da api
  Future updateActicity(Activity activity) async {
    try {
      isLoading = true;
      return await activityService.updateActivity(activity);
    } finally {
      isLoading = false;
    }
  }

  void btnValidarPressed(BuildContext context, ActivityForm widget) async {
    try {
      isLoading;
    } finally {}

    if (isTitleValid == null || !isTitleValid) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Informe todos os campos obrigatórios")),
      );
      return;
    }

    var activity = Activity();
    activity.title = controllerTitle.text.toString();
    activity.activity_type = dropdownTypeValue;
    activity.status = dropdownStatusValue;

    // se for uma nova atividade
    if (widget.activity == null) {
      activity.start_at = DateTime.now();
      activity.end_at = DateTime.now().add(Duration(minutes: 60));
      // activity.description = "fffff";
      activity.account_id = GetIt.instance<Session>().account_id;
      await addActivity(activity).then(
        (isSuccess) {
          if (isSuccess) {
            Navigator.pop(context);
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Dados inseridos com sucesso.")));
          }
        },
      ).catchError(
        (e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Erro no servidor")));
        },
      );
    } else {
      // se nao, atualiza os dados
      widget.activity.title = controllerTitle.text.toString();
      widget.activity.activity_type = dropdownTypeValue;
      widget.activity.status = dropdownStatusValue;

      await updateActicity(widget.activity).then(
        (isSuccess) {
          if (isSuccess) {
            Navigator.pop(context);
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Dados atualizados com sucesso.")));
          }
        },
      ).catchError(
        (e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Erro no servidor")));
        },
      );
    }
  }
}
