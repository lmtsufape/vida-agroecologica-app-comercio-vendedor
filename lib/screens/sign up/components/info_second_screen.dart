import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/shared/core/models/bairro_model.dart';

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
          maskFormatter: controller.cepFormatter,
          controller: controller.cepController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        // DropdownButtonFormField<BairroModel>(
        //   isExpanded: true,
        //   decoration: const InputDecoration(
        //       prefixIcon: Icon(Icons.location_city),
        //       border: InputBorder.none),
        //   style: Theme.of(context).textTheme.titleLarge,
        //   hint: const Text('Bairro'),
        //   value: null,
        //   items: controller.bairros.map((obj) {
        //     return DropdownMenuItem<BairroModel>(
        //       value: obj,
        //       child: Text(obj.nome.toString()),
        //     );
        //   }).toList(),
        //   onChanged: (selectedObj) {
        //     controller.bairroId = selectedObj!.id!.toInt();
        //   },
        // ),
        CustomTextFormField(
          hintText: 'Bairro',
          icon: Icons.location_city,
          controller: controller.bairroController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        CustomTextFormField(
          keyboardType: TextInputType.number,
          hintText: 'Número',
          icon: Icons.home_filled,
          controller: controller.numeroController,
        ),
      ],
    );
  }
}
