// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/screens/signin/components/sign_in_result.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/constants/style_constants.dart';
import 'sign_in_repository.dart';

enum SignInStatus {
  done,
  error,
  loading,
  idle,
}

class SignInController with ChangeNotifier {
  final SignInRepository _repository = SignInRepository();
  String? errorMessage;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var status = SignInStatus.idle;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  SignInController() {
    loadSavedEmail();
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }

  Future<void> loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userEmail');
    if (savedEmail != null) {
      _emailController.text = savedEmail;
      notifyListeners();
    }
  }

  void setErrorMessage(String value) async {
    errorMessage = value;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    errorMessage = null;
    notifyListeners();
  }

  void signIn(BuildContext context) async {
    try {
      status = SignInStatus.loading;
      notifyListeners();

      final result = await _repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      switch (result.type) {
        case SignInResultType.success:
          await saveEmail(_emailController.text);
          status = SignInStatus.done;
          notifyListeners();
          Navigator.pushReplacementNamed(context, Screens.home);
          break;

        case SignInResultType.successNoBanca:
          await saveEmail(_emailController.text);
          status = SignInStatus.done;
          notifyListeners();
          Navigator.pushReplacementNamed(context, Screens.addStore);
          break;

        case SignInResultType.unauthorized:
          _showErrorDialog(
            context,
            title: 'Acesso negado',
            body: 'Você não possui autorização para entrar no aplicativo. Fale com o(a) presidente!',
          );
          break;

        case SignInResultType.invalidCredentials:
          _showErrorDialog(
            context,
            title: 'Erro de login',
            body: 'E-mail ou senha incorretos. Verifique seus dados.',
          );
          break;

        case SignInResultType.serverError:
          _showErrorDialog(
            context,
            title: 'Erro no servidor',
            body: result.message ?? 'Servidor indisponível. Tente novamente mais tarde.',
          );
          break;

        case SignInResultType.networkError:
          _showErrorDialog(
            context,
            title: 'Erro de conexão',
            body: result.message ?? 'Verifique sua conexão com a internet.',
          );
          break;
      }
    } catch (e) {
      _showErrorDialog(
        context,
        title: 'Erro',
        body: 'Ocorreu um erro inesperado. Tente novamente.',
      );
    }
  }

  void _showErrorDialog(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    status = SignInStatus.error;
    setErrorMessage(body);
    notifyListeners();

    showDialog(
      context: context,
      builder: (context) => DefaultAlertDialogOneButton(
        title: title,
        body: body,
        confirmText: 'Voltar',
        onConfirm: () => Get.back(),
        buttonColor: kErrorColor,
      ),
    );
  }
}