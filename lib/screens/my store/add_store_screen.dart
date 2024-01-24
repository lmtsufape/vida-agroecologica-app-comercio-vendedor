import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/my%20store/my_store_controller.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import '../../components/forms/custom_text_form_field.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import 'components/circle_image_profile.dart';

// ignore: must_be_immutable
class AddStoreScreen extends StatefulWidget {

  const AddStoreScreen({Key? key}) : super(key: key);

  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<MyStoreController>(
        init: MyStoreController(),
        builder: (controller) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Criar Banca',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.030),
                ),
              ),
              body: SingleChildScrollView(
                reverse: true,
                child: Form(
                  key: controller.formKey,
                  child: Container(
                      width: size.width,
                      height: size.height * 0.85,
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleImageProfile(controller),
                          ),
                          Text(
                            'Descrição',
                            style: TextStyle(
                                fontSize: size.height * 0.020,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Divider(
                            height: size.height * 0.02,
                            color: Colors.transparent,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome',
                                style: TextStyle(
                                    color: kTextButtonColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.height * 0.014),
                              ),
                              IntrinsicWidth(
                                stepWidth: size.width,
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 0,
                                  child: ClipPath(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: CustomTextFormField(
                                        erroStyle: TextStyle(fontSize: 12),
                                        validatorError: (value) {
                                          if(value.isEmpty){
                                            return 'Obrigatório';
                                          }
                                        },
                                        hintText: "Nome",
                                        controller: controller.nomeBancaController,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const VerticalSpacerBox(size: SpacerSize.small),
                          Text('Horário de Funcionamento',
                              style: kTitle1.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.014,
                                  color: kTextButtonColor)),
                          Divider(
                            height: size.height * 0.008,
                            color: Colors.transparent,
                          ),
                          SizedBox(
                            width: size.width * 0.65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Início',
                                        style: TextStyle(
                                            color: kSecondaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.016),
                                      ),
                                      Divider(
                                        height: size.height * 0.006,
                                        color: Colors.transparent,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.25,
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          elevation: 0,
                                          child: ClipPath(
                                            child: Container(
                                              child: CustomTextFormFieldTime(
                                                erroStyle: TextStyle(fontSize: 12),
                                                validatorError: (value) {
                                                  if(value.isEmpty){
                                                    return 'Obrigatório';
                                                  }
                                                },
                                                hintText: '00:00',
                                                keyboardType: TextInputType.number,
                                                timeFormatter: [
                                                  _HourInputFormatter(),
                                                ],
                                                controller: controller
                                                    .horarioAberturaController,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const VerticalSpacerBox(size: SpacerSize.small),
                                IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Fechamento',
                                        style: TextStyle(
                                            color: kSecondaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: size.height * 0.016),
                                      ),
                                      Divider(
                                        height: size.height * 0.006,
                                        color: Colors.transparent,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.25,
                                        child: Card(
                                          margin: EdgeInsets.zero,
                                          elevation: 0,
                                          child: ClipPath(
                                            child: Container(
                                              child: CustomTextFormFieldTime(
                                                erroStyle: TextStyle(fontSize: 12),
                                                validatorError: (value) {
                                                  if(value.isEmpty){
                                                    return 'Obrigatório';
                                                  }
                                                },
                                                hintText: "23:59",
                                                keyboardType: TextInputType.datetime,
                                                timeFormatter: [
                                                  _HourInputFormatter(),
                                                ],
                                                controller: controller
                                                    .horarioFechamentoController,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: size.height * 0.018,
                            color: Colors.transparent,
                          ),
                          Text('Formas de Pagamento',
                              style: kTitle1.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.height * 0.018,
                                  color: kSecondaryColor)),
                          SizedBox(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsetsDirectional.zero,
                                    activeColor: kPrimaryColor,
                                    value: controller.isSelected[0],
                                    title: Text(
                                      controller.checkItems[0],
                                      style: TextStyle(fontSize: size.height * 0.016),
                                    ),
                                    checkboxShape: const CircleBorder(),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    onChanged: (value) => controller.onItemTapped(0),
                                  ),
                                ),
                                Flexible(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsetsDirectional.zero,
                                    activeColor: kPrimaryColor,
                                    value: controller.isSelected[1],
                                    title: Text(
                                      controller.checkItems[1],
                                      style: TextStyle(fontSize: size.height * 0.016),
                                    ),
                                    checkboxShape: const CircleBorder(),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    onChanged: (value) => controller.onItemTapped(1),
                                  ),
                                ),
                                Flexible(
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsetsDirectional.zero,
                                    activeColor: kPrimaryColor,
                                    value: controller.isSelected[2],
                                    title: Text(
                                      controller.checkItems[2],
                                      style: TextStyle(fontSize: size.height * 0.016),
                                    ),
                                    checkboxShape: const CircleBorder(),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    onChanged: (value) => controller.onItemTapped(2),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: size.width * 0.81,
                            child: Text('Preço mínimo pra frete',
                                style: kTitle1.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: size.height * 0.014,
                                    color: kTextButtonColor)),
                          ),
                          Divider(
                            height: size.height * 0.005,
                            color: Colors.transparent,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Valor',
                                  style: kTitle1.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: size.height * 0.014,
                                      color: kTextButtonColor)),
                              SizedBox(
                                width: size.width * 0.25,
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 0,
                                  child: ClipPath(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: CustomTextFormFieldCurrency(
                                        erroStyle: TextStyle(fontSize: 12),
                                        validatorError: (value) {
                                          if(value.isEmpty){
                                            return 'Obrigatório';
                                          }
                                        },
                                        hintText:
                                        "R\$ 7,00",
                                        currencyFormatter: <TextInputFormatter>[
                                          CurrencyTextInputFormatter(
                                            locale: 'pt-BR',
                                            symbol: 'R\$',
                                            decimalDigits: 2,
                                          ),
                                          LengthLimitingTextInputFormatter(8),
                                        ],
                                        keyboardType: TextInputType.number,
                                        controller: controller.quantiaMinController,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          /*CustomTextFormField(
                            hintText: widget.bancaModel!.precoMin.toString(),
                            icon: Icons.paid,
                            controller: controller.quantiaMinController,
                          ),*/
                          const VerticalSpacerBox(size: SpacerSize.large),
                          PrimaryButton(
                              text: 'Salvar',
                              onPressed: () {
                                final isValidForm = controller.formKey.currentState!.validate();
                                if(isValidForm) {
                                  if (!controller.verifyFields()) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DefaultAlertDialogOneButton(
                                              title: 'Erro',
                                              body: controller.textoErro,
                                              confirmText: 'Voltar',
                                              onConfirm: () => Get.back(),
                                              buttonColor: kAlertColor,
                                            ));
                                  }
                                  else {
                                    controller.adicionarBanca(context);
                                  }
                                }}),
                        ],
                      )),
                ),
              )),
        ));
  }
}


class _HourInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    if (newText.length >= 2) {
      int hours = int.parse(newText.substring(0, 2));
      hours = hours.clamp(0, 23);

      String formattedText = hours.toString().padLeft(2, '0');

      if (newText.length >= 3) {
        int minutes = int.tryParse(newText.substring(2, min(newText.length, 4))) ?? 0;

        // Avoid adding leading zero for the first digit of minutes
        if (newText.length > 3) {
          minutes = minutes.clamp(0, 59);
          formattedText += ':' + minutes.toString().padLeft(2, '0');
        } else {
          formattedText += ':' + minutes.toString();
        }
      } else {
        formattedText += ':' + newText.substring(2);
      }

      newText = formattedText;
    }

    // Allow deleting characters without needing to tap again for the cursor to move
    if (newValue.text.length < oldValue.text.length) {
      newText = newText.substring(0, max(0, newText.length - 1));
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}


