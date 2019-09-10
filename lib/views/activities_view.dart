import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:piperun/_shared/styles.dart';
import 'package:piperun/models/activity.dart';
import 'package:piperun/views/activities_view_model.dart';

class ActivitiesView extends StatefulWidget {
  static String routeName = '/activities';

  @override
  _ActivitiesViewState createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  var viewModel = ActivitiesViewModel();

  @override
  void initState() {
    super.initState();

    // escuta atualizacoes do estado do app, providos pelo viewmodel
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Atividades"),
      ),
      // se carregou os dados, exibe os Widgets com os dados, se nao, exibe o Widget de loading
      body: viewModel.isLoading ? _buildLoading() : _buildBody(),
      // insere os Floating Action Buttons para filtragem e criacao de novas atividades
      floatingActionButton: viewModel.isLoading ? null : _buildFabs(),
    );
  }

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Row _buildFabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Botao pesquisar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            heroTag: '1',
            onPressed: () => viewModel.fabPesquisaPressed(context),
            child: Icon(Icons.search),
          ),
        ),

        // Botao Nova Ativdade
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            heroTag: '2',
            onPressed: () => viewModel.fabAdicionaPressed(context),
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  // Cria os Cards de Atividades para cada atividade, e os insere em um scrollview
  Widget _buildBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          // itera e cria um card para cada item da lista
          for (var item in viewModel.lstActivities) _buildCardAtividades(item),
          Container(
            height: 90,
          )
        ],
      ),
    );
  }

  Card _buildCardAtividades(Activity item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildLabelTitle(item),
                  _buildLabelData(item),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildIconButtonConcluir(item),
                  _buildIconButtonEditar(item),
                  _buildIconButtonDelete(item),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildLabelTitle(Activity item) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            item.title,
            style: uiActivityCardTitleStyle(),
          ),
        ));
  }

  Align _buildLabelData(Activity item) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            DateFormat('dd/MM/yyyy HH:mm').format(item.start_at),
            style: uiActivityCardSubTitleStyle(),
          ),
        ));
  }

  IconButton _buildIconButtonConcluir(Activity item) {
    return IconButton(
      icon: Icon(Icons.check),
      iconSize: 24,
      color: Colors.green.shade900,
      onPressed: () => viewModel.btnConcluirPressed(context, item),
    );
  }

  IconButton _buildIconButtonEditar(Activity item) {
    return IconButton(
      icon: Icon(Icons.edit),
      iconSize: 24,
      color: Colors.grey.shade700,
      onPressed: () => viewModel.btnEditarPressed(context, item),
    );
  }

  IconButton _buildIconButtonDelete(Activity item) {
    return IconButton(
      icon: Icon(Icons.delete),
      iconSize: 24,
      color: Colors.red.shade800,
      onPressed: () => viewModel.btnDeletePressed(context, item),
    );
  }
}
