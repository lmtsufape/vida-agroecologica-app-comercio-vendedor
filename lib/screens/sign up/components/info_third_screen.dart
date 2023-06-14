import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../components/forms/custom_text_form_field.dart';
import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';

import '../sign_up_controller.dart';

// ignore: must_be_immutable
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
              child: CustomTextFormField(
                hintText: '00:00:00',
                keyboardType: TextInputType.number,
                maskFormatter:
                    widget.controller.timeFormatter,
                icon: Icons.alarm_on,
                controller: widget
                    .controller.horarioAberturaController,
              ),
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Expanded(
              child: CustomTextFormField(
                hintText: '00:00:00',
                keyboardType: TextInputType.number,
                maskFormatter:
                    widget.controller.timeFormatter,
                icon: Icons.alarm_off,
                controller: widget
                    .controller.horarioFechamentoController,
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
