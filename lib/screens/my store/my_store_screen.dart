import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/my%20store/my_store_controller.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import '../../components/forms/custom_text_form_field.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import 'components/circle_image_profile.dart';

// ignore: must_be_immutable
class MyStoreScreen extends StatefulWidget {
  BancaModel? bancaModel;

  MyStoreScreen(this.bancaModel, {Key? key})
      : super(key: key);

  @override
  State<MyStoreScreen> createState() =>
      _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<MyStoreController>(
        init: MyStoreController(),
        builder: (controller) => Scaffold(
            appBar: AppBar(
              title: const Text(
                'Minha Loja',
                style: kTitle2,
              ),
            ),
            body: Container(
                width: size.width,
                height: size.height,
                padding:
                    const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Center(
                      child: CircleImageProfile(controller),
                    ),
                    CustomTextFormField(
                      hintText: widget.bancaModel!.nome,
                      icon: Icons.person,
                      controller:
                          controller.nomeBancaController,
                    ),
                    const VerticalSpacerBox(
                        size: SpacerSize.small),
                    SizedBox(
                      width: size.width * 0.81,
                      child: Text(
                          'Horário de Funcionamento',
                          style: kTitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kSecondaryColor)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            hintText: widget.bancaModel!
                                .horarioAbertura,
                            keyboardType:
                                TextInputType.number,
                            maskFormatter: controller
                                .timeFormatter,
                            icon: Icons.alarm_on,
                            controller: controller
                                .horarioAberturaController,
                          ),
                        ),
                        const VerticalSpacerBox(
                            size: SpacerSize.small),
                        Expanded(
                          child: CustomTextFormField(
                            hintText: widget.bancaModel!
                                .horarioFechamento,
                            keyboardType:
                                TextInputType.number,
                            maskFormatter: controller
                                .timeFormatter,
                            icon: Icons.alarm_off,
                            controller: controller
                                .horarioFechamentoController,
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
                            value: controller.isSelected[0],
                            title: Text(
                                controller.checkItems[0]),
                            checkboxShape:
                                const CircleBorder(),
                            controlAffinity:
                                ListTileControlAffinity
                                    .leading,
                            onChanged: (value) =>
                                controller.onItemTapped(0),
                          ),
                        ),
                        Flexible(
                            child: Padding(
                                padding: const EdgeInsets
                                        .symmetric(
                                    horizontal: 8.0),
                                child: CheckboxListTile(
                                  value: controller
                                      .isSelected[1],
                                  title: Text(controller
                                      .checkItems[1]),
                                  checkboxShape:
                                      const CircleBorder(),
                                  controlAffinity:
                                      ListTileControlAffinity
                                          .leading,
                                  onChanged: (value) =>
                                      controller
                                          .onItemTapped(1),
                                ))),
                      ],
                    ),
                    CheckboxListTile(
                        title: Text('Realiza Entrega?',
                            style: kTitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: kSecondaryColor)),
                        value: controller.deliver,
                        checkboxShape: const CircleBorder(),
                        onChanged: (bool? value) {
                          controller.setDeliver(value!);
                        }),
                    SizedBox(
                      width: size.width * 0.81,
                      child: Text(
                          'Quantia mínima para entrega',
                          style: kTitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kSecondaryColor)),
                    ),
                    CustomTextFormField(
                      hintText: widget.bancaModel!.precoMin
                          .toString(),
                      icon: Icons.paid,
                      controller:
                          controller.quantiaMinController,
                    ),
                    const VerticalSpacerBox(
                        size: SpacerSize.huge),
                    PrimaryButton(
                        text: 'Editar Banca',
                        onPressed: () {
                          if (controller
                              .verifySelectedFields()) {
                            controller.editBanca(context,
                                widget.bancaModel!);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    DefaultAlertDialogOneButton(
                                      title: 'Erro',
                                      body:
                                          'Adicione pelo menos uma forma de pagamento',
                                      confirmText: 'Ok',
                                      onConfirm: () =>
                                          Get.back(),
                                      buttonColor:
                                          kAlertColor,
                                    ));
                          }
                        }),
                  ],
                ))));
  }
}
