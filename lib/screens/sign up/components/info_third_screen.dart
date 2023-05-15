import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../components/forms/custom_text_form_field.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/constants/app_number_constants.dart';
import '../sign_up_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';

class InfoThirdScreen extends StatefulWidget {
  late SignUpController controller;
  InfoThirdScreen(this.controller, {super.key});

  @override
  State<InfoThirdScreen> createState() =>
      _InfoThirdScreenState();
}

class _InfoThirdScreenState extends State<InfoThirdScreen> {
  void _onItemTapped(int index) {
    setState(() {
      widget.controller.isSelected[index] =
          !widget.controller.isSelected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CustomTextFormField(
          hintText: 'Nome da Banca',
          icon: Icons.person,
          controller: widget.controller.nomeBancaController,
        ),
        const VerticalSpacerBox(size: SpacerSize.small),
        SizedBox(
          width: size.width * 0.81,
          child: Text('Horário de Funcionamento',
              style: kTitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kSecondaryColor)),
        ),
        Row(
          children: [
            Expanded(
              child: DateTimePicker(
                type: DateTimePickerType.time,
                timeLabelText: "Abertura",
                controller: widget
                    .controller.horarioAberturaController,
                use24HourFormat: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Abertura',
                  prefixIcon: Icon(Icons.alarm),
                ),
                onChanged: (val) => print(val),
                validator: (val) {
                  return null;
                },
                onSaved: (val) => print(val),
              ),
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Expanded(
              child: DateTimePicker(
                type: DateTimePickerType.time,
                timeLabelText: "Fechamento",
                locale: const Locale('pt', 'BR'),
                controller: widget
                    .controller.horarioFechamentoController,
                use24HourFormat: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Fechamento',
                  prefixIcon: Icon(Icons.alarm_off),
                ),
                onChanged: (val) => print(val),
                validator: (val) {
                  return null;
                },
                onSaved: (val) => print(val),
              ),
            ),
          ],
        ),
        SizedBox(
          width: size.width * 0.81,
          child: Text('Formas de Pagamento',
              style: kTitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kSecondaryColor)),
        ),
        Row(
          children: [
            Flexible(
              child: CheckboxListTile(
                value: widget.controller.isSelected[0],
                title:
                    Text(widget.controller.checkItems[0]),
                checkboxShape: const CircleBorder(),
                controlAffinity:
                    ListTileControlAffinity.leading,
                onChanged: (value) => _onItemTapped(0),
              ),
            ),
            Flexible(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0),
                    child: CheckboxListTile(
                      value:
                          widget.controller.isSelected[1],
                      title: Text(
                          widget.controller.checkItems[1]),
                      checkboxShape: const CircleBorder(),
                      controlAffinity:
                          ListTileControlAffinity.leading,
                      onChanged: (value) =>
                          _onItemTapped(1),
                    ))),
          ],
        ),
        CheckboxListTile(
            title: Text('Realiza Entrega?',
                style: kTitle1.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: kSecondaryColor)),
            value: widget.controller.deliver,
            checkboxShape: const CircleBorder(),
            onChanged: (bool? value) {
              widget.controller.setDeliver(value!);
            }),
        SizedBox(
          width: size.width * 0.81,
          child: Text('Quantia mínima para entrega',
              style: kTitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kSecondaryColor)),
        ),
        CustomTextFormField(
          hintText: 'R\$ 0,00',
          icon: Icons.paid,
          controller:
              widget.controller.quantiaMinController,
        ),
      ],
    );
  }
}
