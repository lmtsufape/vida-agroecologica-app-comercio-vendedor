import 'package:flutter/material.dart';

import '../../../components/forms/custom_text_form_field.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../sign_up_controller.dart';

// ignore: must_be_immutable
class InfoFirstScreen extends StatelessWidget {
  late SignUpController controller;
  InfoFirstScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hintText: 'Nome',
          icon: Icons.person,
          controller: controller.nomeController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Apelido',
          icon: Icons.person,
          controller: controller.apelidoController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'CPF',
          icon: Icons.description,
          maskFormatter: controller.cpfFormatter,
          controller: controller.cpfController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'E-mail',
          icon: Icons.email,
          controller: controller.emailController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Senha',
          onChanged: (value) =>
              controller.checkPasswordStrength(
                  controller.passwordController.text),
          isPassword: true,
          icon: Icons.lock,
          controller: controller.passwordController,
        ),
        LinearProgressIndicator(
          value: controller.strength,
          backgroundColor: Colors.grey[300],
          color: controller.strength <= 1 / 4
              ? Colors.red
              : controller.strength == 2 / 4
                  ? Colors.yellow
                  : controller.strength == 3 / 4
                      ? Colors.blue
                      : Colors.green,
          minHeight: 15,
        ),
        Text(
          controller.displayText,
          style: const TextStyle(
              color: Colors.black, fontSize: 16),
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Telefone',
          maskFormatter: controller.phoneFormatter,
          icon: Icons.phone,
          controller: controller.telefoneController,
        ),
      ],
    );
  }
}
