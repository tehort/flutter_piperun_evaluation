import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piperun/services/dialogs.dart';
import 'package:piperun/views/login_view_model.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  static String routeName = 'login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var viewModel = LoginViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showFecharAplicativo(context),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _buildBody(context),
            // se estiver carregando, apresenta o buildLoading como overlay
            viewModel.isLoading ? _buildLoading() : Container(),
          ],
        ),
      ),
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

  Widget _buildBody(BuildContext context) {
    // GestureDetector permite remover o foco do componente, ao tocar na tela
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        FocusScope.of(context).consumeKeyboardToken();
      },
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: <Widget>[
          Center(
            // wallpaper de fundo
            child: _buildBackground(),
          ),
          // componentes da tela
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildImgLogo(),
                _buildTextFieldEmail(),
                const SizedBox(height: 12.0),
                _buildTextFieldPassword(),
                const SizedBox(height: 6.0),
                _buildBtnLogin(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/login_background.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _buildImgLogo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 100),
        child: Image.asset(
          'resources/login_logo.png',
        ),
      ),
    );
  }

  Widget _buildTextFieldEmail() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Container(
        width: double.infinity,
        child: TextFormField(
          controller: viewModel.emailController,
          focusNode: viewModel.emailInputFocusNode,
          onEditingComplete: () => FocusScope.of(context).requestFocus(viewModel.passwordInputFocusNode),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          textCapitalization: TextCapitalization.words,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.pink),
            filled: true,
            labelText: 'Informe seu e-mail',
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Container(
        width: double.infinity,
        child: TextFormField(
          controller: viewModel.passwordController,
          focusNode: viewModel.passwordInputFocusNode,
          keyboardType: TextInputType.text,
          obscureText: true,
          onEditingComplete: () => FocusScope.of(context).requestFocus(new FocusNode()),
          textInputAction: TextInputAction.next,
          maxLines: 1,
          textCapitalization: TextCapitalization.words,
          enableInteractiveSelection: false,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.pink),
            filled: true,
            labelText: 'Informe sua senha',
          ),
        ),
      ),
    );
  }

  Widget _buildBtnLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Container(
        width: double.infinity,
        height: 64,
        child: RaisedButton.icon(
          color: Colors.red.shade300,
          textColor: Colors.white,
          highlightElevation: 0,
          disabledElevation: 0,
          elevation: 2,
          icon: const Icon(Icons.exit_to_app, size: 24.0, color: Colors.white),
          label: const Text('ENTRAR'),
          onPressed: () async {
            viewModel.btnLoginPressed(context);
          },
        ),
      ),
    );
  }
}
