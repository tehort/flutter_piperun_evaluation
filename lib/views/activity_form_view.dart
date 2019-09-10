import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:piperun/models/activity.dart';
import 'package:piperun/models/activity_status.dart';
import 'package:piperun/models/session.dart';
import 'package:piperun/views/activity_form_view_model.dart';

class ActivityForm extends StatefulWidget {
  static String routeName = '/activityForm';
  final Activity activity;

  ActivityForm({this.activity});

  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  ActivityFormViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ActivityFormViewModel();

    viewModel.addListener(() {
      setState(() {});
    });

    if (widget.activity != null) {
      viewModel.isTitleValid = true;
      viewModel.controllerTitle.text = widget.activity.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.activity == null ? "Adicionar Nova Atividade" : "Alterar Atividade",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: viewModel.isLoading ? _buildLoading() : _buildBody(),
    );
  }

  Widget _buildLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      foregroundDecoration: BoxDecoration(backgroundBlendMode: BlendMode.darken, color: Colors.black12),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _uiTextFieldTitle(),
                Padding(padding: const EdgeInsets.fromLTRB(8, 8, 8, 0), child: Text("Selecione o Responsável")),
                _uiDropdownButtonResponsible(),
                Padding(padding: const EdgeInsets.fromLTRB(8, 8, 8, 0), child: Text("Selecione o Status")),
                _uiDropdownButtonStatus(),
                Padding(padding: const EdgeInsets.fromLTRB(8, 8, 8, 0), child: Text("Selecione o Tipo")),
                _uiDropdownButtonType(),
                _uiBtnValidate()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _uiTextFieldTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: viewModel.controllerTitle,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Título da atividade",
          errorText: viewModel.isTitleValid == null || viewModel.isTitleValid ? null : "É necessário inserir o título da atividade",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != viewModel.isTitleValid) {
            setState(() => viewModel.isTitleValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _uiDropdownButtonResponsible() {
    var lstDropdownItems = List<DropdownMenuItem<String>>();
    lstDropdownItems.add(DropdownMenuItem(
      value: GetIt.instance<Session>().name,
      child: Text(GetIt.instance<Session>().name),
    ));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: DropdownButton<String>(
          isExpanded: true,
          value: viewModel.dropdownResponsibleValue,
          onChanged: (String newValue) {
            setState(() {
              viewModel.dropdownResponsibleValue = newValue;
            });
          },
          items: lstDropdownItems,
        ),
      ),
    );
  }

  Widget _uiDropdownButtonStatus() {
    var lstDropdownItems = List<DropdownMenuItem<int>>();
    for (var item in ActivityStatus.getList()) {
      lstDropdownItems.add(DropdownMenuItem(
        value: item.index,
        child: Text(item.description),
      ));
    }

    if (viewModel.dropdownStatusValue == null) {
      if (widget.activity != null) {
        viewModel.dropdownStatusValue = widget.activity.status;
      } else {
        viewModel.dropdownStatusValue = ActivityStatus.getList().first.index;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: DropdownButton<int>(
          isExpanded: true,
          value: viewModel.dropdownStatusValue,
          onChanged: (int newValue) {
            setState(() {
              viewModel.dropdownStatusValue = newValue;
            });
          },
          items: lstDropdownItems,
        ),
      ),
    );
  }

  Widget _uiDropdownButtonType() {
    var lstDropdownItems = List<DropdownMenuItem<int>>();
    for (var item in viewModel.getActivityTypes) {
      lstDropdownItems.add(DropdownMenuItem(
        value: item.id,
        child: Text(item.name),
      ));
    }

    if (viewModel.dropdownTypeValue == null) {
      if (widget.activity != null) {
        viewModel.dropdownTypeValue = widget.activity.activity_type;
      } else {
        viewModel.dropdownTypeValue = viewModel.getActivityTypes.first.id;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: DropdownButton<int>(
          isExpanded: true,
          value: viewModel.dropdownTypeValue,
          onChanged: (int newValue) {
            setState(() {
              viewModel.dropdownTypeValue = newValue;
            });
          },
          items: lstDropdownItems,
        ),
      ),
    );
  }

  Widget _uiBtnValidate() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RaisedButton(
          child: Text(
            widget.activity == null ? "Criar Atividade" : "Atualizar Atividade",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.red.shade300,
          onPressed: () => viewModel.btnValidarPressed(context, widget)),
    );
  }
}
