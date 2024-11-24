// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunderapp/screens/screens_index.dart';
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

  // Getters for controllers
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  // Constructor to load saved email on initialization
  SignInController() {
    loadSavedEmail();
  }

  // Save email to SharedPreferences
  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }

  // Load email from SharedPreferences
  Future<void> loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userEmail');
    if (savedEmail != null) {
      _emailController.text = savedEmail;
      notifyListeners();
    }
  }

  // Set error message with delay for reset
  void setErrorMessage(String value) async {
    errorMessage = value;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    errorMessage = null;
    notifyListeners();
  }

  // Sign-in method
  void signIn(BuildContext context) async {
    try {
      status = SignInStatus.loading;
      notifyListeners();

      var succ = await _repository.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (succ == 1 || succ == 2) {
        // Save email on successful login
        await saveEmail(_emailController.text);

        status = SignInStatus.done;
        notifyListeners();

        Navigator.pushReplacementNamed(
          context,
          succ == 1 ? Screens.home : Screens.addStore,
        );
      } else if (succ == 3) {
        showDialog(
          context: context,
          builder: (context) => DefaultAlertDialogOneButton(
            title: 'Erro',
            body: 'Você não possui autorização para entrar no aplicativo, fale com o(a) presidente!',
            confirmText: 'Voltar',
            onConfirm: () => Get.back(),
            buttonColor: kErrorColor,
          ),
        );
        status = SignInStatus.error;
        setErrorMessage('Você não possui autorização para entrar no aplicativo.');
      } else {
        showDialog(
          context: context,
          builder: (context) => DefaultAlertDialogOneButton(
            title: 'Erro',
            body: 'Credenciais inválidas, verifique seus dados',
            confirmText: 'Voltar',
            onConfirm: () => Get.back(),
            buttonColor: kErrorColor,
          ),
        );
        status = SignInStatus.error;
        setErrorMessage('Credenciais inválidas, verifique seus dados.');
      }
      notifyListeners();
    } catch (e) {
      status = SignInStatus.error;
      setErrorMessage('Credenciais inválidas, verifique seus dados.');
      notifyListeners();
    }
  }
}
