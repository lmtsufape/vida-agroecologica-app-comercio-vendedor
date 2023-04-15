import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/forms/custom_text_form_field.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../sign_up_controller.dart';

class InfoSecondScreen extends StatelessWidget {
  late SignUpController controller;
  InfoSecondScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          hintText: 'Rua',
          icon: Icons.location_city,
          controller: controller.ruaController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'CEP',
          icon: Icons.numbers_outlined,
          controller: controller.cepController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Bairro',
          icon: Icons.location_city_rounded,
          controller: controller.bairroController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          hintText: 'Número',
          icon: Icons.home_filled,
          controller: controller.numeroController,
        ),
      ],
    );
  }
}
