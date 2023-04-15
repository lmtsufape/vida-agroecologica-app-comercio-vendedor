import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/forms/custom_text_form_field.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../sign_up_controller.dart';

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
          hintText: 'E-mail',
          icon: Icons.email,
          controller: controller.emailController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Senha',
          isPassword: true,
          icon: Icons.lock,
          controller: controller.passwordController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Telefone',
          icon: Icons.phone,
          controller: controller.telefoneController,
        ),
      ],
    );
  }
}
