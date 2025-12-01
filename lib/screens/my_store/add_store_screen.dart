// ignore_for_file: avoid_unnecessary_containers, avoid_print
import 'dart:math';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/my_store/my_store_controller.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import '../../assets/index.dart';
import '../../components/forms/custom_text_form_field.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import 'components/circle_image_profile.dart';

// ignore: must_be_immutable
class AddStoreScreen extends StatefulWidget {
  const AddStoreScreen({Key? key}) : super(key: key);

  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

TimeOfDay _getInitialTime(TextEditingController controller) {
  final timeParts = controller.text.split(':');
  if (timeParts.length == 2) {
    final hour = int.tryParse(timeParts[0]) ?? 0;
    final minute = int.tryParse(timeParts[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }
  return TimeOfDay.now();
}

String _formatTimeOfDayTo24Hour(TimeOfDay time) {
  final String hour = time.hour.toString().padLeft(2, '0');
  final String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
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
                    backgroundColor: kPrimaryColor,
                    centerTitle: true,
                    title: Text(
                      'Criar Banca',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: size.height * 0.030),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  body: SingleChildScrollView(
                    reverse: true,
                    child: Form(
                      key: controller.formKey,
                      child: Container(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleImageProfile(controller),
                              ),
                              Divider(
                                height: size.height * 0.02,
                                color: Colors.transparent,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nome da banca',
                                    style: TextStyle(
                                        fontSize: size.height * 0.018,
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.w700),
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
                                            autoValidate: AutovalidateMode
                                                .onUserInteraction,
                                            erroStyle:
                                                const TextStyle(fontSize: 12),
                                            validatorError: (value) {
                                              if (value.isEmpty) {
                                                return 'Obrigatório';
                                              }
                                            },
                                            hintText: "Nome",
                                            controller:
                                                controller.nomeBancaController,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const VerticalSpacerBox(size: SpacerSize.small),
                              /*SizedBox(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Horário de abertura',
                                          style: TextStyle(
                                            color: kSecondaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.height * 0.018,
                                          ),
                                        ),
                                        Divider(
                                            height: size.height * 0.006,
                                            color: Colors.transparent),
                                        IconButton(
                                          icon: const Icon(Icons.access_time),
                                          onPressed: () async {
                                            final selectedTime =
                                                await showTimePicker(
                                              context: context,
                                              cancelText: "Cancelar",
                                              confirmText: "Confirmar",
                                              hourLabelText: "Horas",
                                              minuteLabelText: "Minutos",
                                              helpText: "Insira o horário:",
                                              initialTime: _getInitialTime(
                                                  controller
                                                      .horarioAberturaController),
                                              initialEntryMode:
                                                  TimePickerEntryMode.inputOnly,
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary: kPrimaryColor,
                                                      onPrimary: Colors.white,
                                                      onSurface: kPrimaryColor,
                                                    ),
                                                  ),
                                                  child: MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                true),
                                                    child: child!,
                                                  ),
                                                );
                                              },
                                            );

                                            if (selectedTime != null) {
                                              final formattedTime =
                                                  _formatTimeOfDayTo24Hour(
                                                      selectedTime);
                                              final fechamentoTime = controller
                                                  .horarioFechamentoController
                                                  .text;

                                              if (fechamentoTime.isNotEmpty &&
                                                  _isClosingTimeInvalid(
                                                      formattedTime,
                                                      fechamentoTime)) {
                                                _showSnackbar(context,
                                                    "O horário de abertura deve ser menor que o de fechamento.");
                                                return;
                                              }

                                              setState(() {
                                                controller
                                                    .horarioAberturaController
                                                    .text = formattedTime;
                                              });
                                            }
                                          },
                                        ),
                                        if (controller.horarioAberturaController
                                            .text.isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              controller
                                                  .horarioAberturaController
                                                  .text,
                                              style: TextStyle(
                                                color: kSecondaryColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: size.height * 0.018,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Término dos pedidos',
                                          style: TextStyle(
                                            color: kSecondaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.height * 0.018,
                                          ),
                                        ),
                                        Divider(
                                            height: size.height * 0.006,
                                            color: Colors.transparent),
                                        IconButton(
                                          icon: const Icon(Icons.access_time),
                                          onPressed: () async {
                                            final selectedTime =
                                                await showTimePicker(
                                              context: context,
                                              cancelText: "Cancelar",
                                              confirmText: "Confirmar",
                                              hourLabelText: "Horas",
                                              minuteLabelText: "Minutos",
                                              helpText: "Insira o horário:",
                                              initialTime: _getInitialTime(
                                                  controller
                                                      .horarioFechamentoController),
                                              initialEntryMode:
                                                  TimePickerEntryMode.inputOnly,
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary: kPrimaryColor,
                                                      onPrimary: Colors.white,
                                                      onSurface: kPrimaryColor,
                                                    ),
                                                  ),
                                                  child: MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                true),
                                                    child: child!,
                                                  ),
                                                );
                                              },
                                            );

                                            if (selectedTime != null) {
                                              final formattedTime =
                                                  _formatTimeOfDayTo24Hour(
                                                      selectedTime);
                                              final aberturaTime = controller
                                                  .horarioAberturaController
                                                  .text;

                                              if (_isClosingTimeInvalid(
                                                  aberturaTime,
                                                  formattedTime)) {
                                                _showSnackbar(context,
                                                    "O horário de fechamento deve ser maior que o de abertura.");
                                                return;
                                              }

                                              setState(() {
                                                controller
                                                    .horarioFechamentoController
                                                    .text = formattedTime;
                                              });
                                            }
                                          },
                                        ),
                                        if (controller
                                            .horarioFechamentoController
                                            .text
                                            .isNotEmpty)
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              controller
                                                  .horarioFechamentoController
                                                  .text,
                                              style: TextStyle(
                                                color: kSecondaryColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: size.height * 0.018,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),*/
                              Divider(
                                height: size.height * 0.018,
                                color: Colors.transparent,
                              ),
                              Text(
                                'Formas de Pagamento',
                                style: TextStyle(
                                    fontSize: size.height * 0.018,
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: CheckboxListTile(
                                          contentPadding:
                                              EdgeInsetsDirectional.zero,
                                          activeColor: kPrimaryColor,
                                          value: controller.isSelected[0],
                                          title: Text(
                                            controller.checkItems[0],
                                            style: TextStyle(
                                                fontSize: size.height * 0.016),
                                          ),
                                          checkboxShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          onChanged: (value) {
                                            controller.onItemTapped(0);
                                            controller.setCashBool(
                                                !controller.cashBool);
                                          }),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                          contentPadding:
                                              EdgeInsetsDirectional.zero,
                                          activeColor: kPrimaryColor,
                                          value: controller.isSelected[1],
                                          title: Text(
                                            controller.checkItems[1],
                                            style: TextStyle(
                                                fontSize: size.height * 0.016),
                                          ),
                                          checkboxShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          onChanged: (value) {
                                            controller.onItemTapped(1);
                                            controller.setPixBool(
                                                !controller.pixBool);
                                            print(
                                                "valor do pix: ${controller.pixBool}");
                                            print(
                                                "valor do isSelected: ${controller.isSelected}");
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: controller.pixBool,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Chave Pix',
                                      style: TextStyle(
                                          fontSize: size.height * 0.018,
                                          color: kSecondaryColor,
                                          fontWeight: FontWeight.w700),
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
                                              autoValidate: AutovalidateMode
                                                  .onUserInteraction,
                                              enabled: controller.pixBool,
                                              erroStyle:
                                                  const TextStyle(fontSize: 12),
                                              validatorError: (value) {
                                                if (controller.pixBool ==
                                                    true) {
                                                  if (value.isEmpty) {
                                                    return 'Obrigatório';
                                                  }
                                                }
                                              },
                                              hintText: "Chave Pix",
                                              controller:
                                                  controller.pixController,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const VerticalSpacerBox(
                                        size: SpacerSize.small),
                                  ],
                                ),
                              ),
                              Divider(
                                height: size.height * 0.018,
                                color: Colors.transparent,
                              ),
                              Text(
                                'Dias de Funcionamento',
                                style: TextStyle(
                                  fontSize: size.height * 0.018,
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              const VerticalSpacerBox(size: SpacerSize.small),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: List.generate(
                                  controller.diasSemana.length,
                                  (index) => FilterChip(
                                    selectedColor: kPrimaryColor.withOpacity(0.2),
                                    checkmarkColor: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(
                                        color: controller.diasSelecionados[index] 
                                            ? kPrimaryColor 
                                            : Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    label: Text(
                                      controller.diasSemana[index],
                                      style: TextStyle(
                                        color: controller.diasSelecionados[index] 
                                            ? kPrimaryColor 
                                            : kSecondaryColor,
                                      ),
                                    ),
                                    selected: controller.diasSelecionados[index],
                                    onSelected: (_) {
                                      if (!controller.diasSelecionados[index]) {
                                        // Se o dia está sendo selecionado (não estava selecionado antes)
                                        _mostrarDialogConfiguracaoHorario(context, controller, index);
                                      } else {
                                        // Se o dia está sendo desmarcado, apenas desmarque
                                        controller.toggleDiaSemana(index);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const VerticalSpacerBox(size: SpacerSize.medium),
                              // Text(
                              //   'Realizará entregas?',
                              //   style: TextStyle(
                              //       fontSize:
                              //           size.height * 0.018,
                              //       color: kSecondaryColor,
                              //       fontWeight:
                              //           FontWeight.w700),
                              // ),
                              // SizedBox(
                              //   height: size.height * 0.08,
                              //   child: Column(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment
                              //             .spaceBetween,
                              //     children: [
                              //       Flexible(
                              //         child: ListTileTheme(
                              //           horizontalTitleGap:
                              //               0,
                              //           child:
                              //               CheckboxListTile(
                              //                   contentPadding:
                              //                       EdgeInsets
                              //                           .zero,
                              //                   activeColor:
                              //                       kPrimaryColor,
                              //                   value: controller
                              //                           .delivery[
                              //                       0],
                              //                   title: Text(
                              //                     'Sim',
                              //                     style: TextStyle(
                              //                         fontSize:
                              //                             size.height * 0.018),
                              //                   ),
                              //                   checkboxShape:
                              //                       const CircleBorder(),
                              //                   controlAffinity:
                              //                       ListTileControlAffinity
                              //                           .leading,
                              //                   onChanged:
                              //                       (value) {
                              //                     controller
                              //                         .onDeliveryTapped(
                              //                             0);
                              //                   }),
                              //         ),
                              //       ),
                              //       Flexible(
                              //           child:
                              //               ListTileTheme(
                              //         horizontalTitleGap: 0,
                              //         child:
                              //             CheckboxListTile(
                              //           contentPadding:
                              //               EdgeInsets.zero,
                              //           activeColor:
                              //               kPrimaryColor,
                              //           value: controller
                              //               .delivery[1],
                              //           title: Text(
                              //             'Não',
                              //             style: TextStyle(
                              //                 fontSize: size
                              //                         .height *
                              //                     0.018),
                              //           ),
                              //           checkboxShape:
                              //               const CircleBorder(),
                              //           controlAffinity:
                              //               ListTileControlAffinity
                              //                   .leading,
                              //           onChanged: (value) =>
                              //               controller
                              //                   .onDeliveryTapped(
                              //                       1),
                              //         ),
                              //       )),
                              //     ],
                              //   ),
                              // ),
                              // Visibility(
                              //   visible:
                              //       controller.delivery[0],
                              //   child: Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment
                              //             .start,
                              //     children: [
                              //       Divider(
                              //         height: size.height *
                              //             0.025,
                              //         color: Colors
                              //             .transparent,
                              //       ),
                              //       Text(
                              //         'Valor mínimo para frete',
                              //         style: TextStyle(
                              //             fontSize:
                              //                 size.height *
                              //                     0.018,
                              //             color:
                              //                 kSecondaryColor,
                              //             fontWeight:
                              //                 FontWeight
                              //                     .w700),
                              //       ),
                              //       SizedBox(
                              //         width:
                              //             size.width * 0.35,
                              //         child: Card(
                              //           margin:
                              //               EdgeInsets.zero,
                              //           elevation: 0,
                              //           child: ClipPath(
                              //             child: Container(
                              //               alignment:
                              //                   Alignment
                              //                       .center,
                              //               child:
                              //                   CustomTextFormFieldCurrency(
                              //                 autoValidate:
                              //                     AutovalidateMode
                              //                         .onUserInteraction,
                              //                 enabled:
                              //                     controller
                              //                         .delivery[0],
                              //                 erroStyle:
                              //                     const TextStyle(
                              //                         fontSize:
                              //                             12),
                              //                 validatorError:
                              //                     (value) {
                              //                   if (controller
                              //                           .delivery[0] ==
                              //                       true) {
                              //                     if (value
                              //                         .isEmpty) {
                              //                       return 'Obrigatório';
                              //                     }
                              //                   }
                              //                 },
                              //                 hintText:
                              //                     "R\$ 7,00",
                              //                 currencyFormatter: <TextInputFormatter>[
                              //                   CurrencyTextInputFormatter
                              //                       .currency(
                              //                     locale:
                              //                         'pt_BR',
                              //                     symbol:
                              //                         'R\$',
                              //                     decimalDigits:
                              //                         2,
                              //                   ),
                              //                   LengthLimitingTextInputFormatter(
                              //                       8),
                              //                 ],
                              //                 keyboardType:
                              //                     TextInputType
                              //                         .number,
                              //                 controller:
                              //                     controller
                              //                         .quantiaMinController,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              /*CustomTextFormField(
                            hintText: widget.bancaModel!.precoMin.toString(),
                            icon: Icons.paid,
                            controller: controller.quantiaMinController,
                          ),*/
                              const VerticalSpacerBox(size: SpacerSize.large),
                              PrimaryButton(
                                  text: 'Salvar',
                                  onPressed: () {
                                    final isValidForm = controller
                                        .formKey.currentState!
                                        .validate();
                                    if (isValidForm) {
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
                                      } else {
                                        controller.adicionarBanca(context);
                                        print("TEM PIX? ${controller.pixBool}");
                                        print("Valor isSelected? ${controller.isSelected}");
                                      }
                                    }
                                  }),
                            ],
                          )),
                    ),
                  )),
            ));
  }
}

List<int> _extractHoursAndMinutes(String time) {
  final exp = RegExp(r"(\d{2})+:?(\d{2})+");
  Match? match = exp.firstMatch(time);

  if (match != null) {
    int hours = int.parse(match.group(1)!);
    int minutes = int.parse(match.group(2)!);
    return [hours, minutes];
  } else {
    // Se não houver correspondência, retorna uma lista com valores padrão
    return [0, 0];
  }
}

String? _validateTimes(String startTime, String endTime) {
  List<int> start = _extractHoursAndMinutes(startTime);
  List<int> end = _extractHoursAndMinutes(endTime);
  if ((start[0] * 60 + start[1]) >= (end[0] * 60 + end[1])) {
    return 'O horário de início deve ser anterior ao horário de término.';
  }
  return null;
}

class _HourInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    if (newText.length >= 2) {
      int hours = int.parse(newText.substring(0, 2));
      hours = hours.clamp(0, 23);

      String formattedText = hours.toString().padLeft(2, '0');

      if (newText.length >= 3) {
        int minutes =
            int.tryParse(newText.substring(2, min(newText.length, 4))) ?? 0;

        // Avoid adding leading zero for the first digit of minutes
        if (newText.length > 3) {
          minutes = minutes.clamp(0, 59);
          formattedText += ':${minutes.toString().padLeft(2, '0')}';
        } else {
          formattedText += ':$minutes';
        }
      } else {
        formattedText += ':${newText.substring(2)}';
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

void _mostrarDialogConfiguracaoHorario(BuildContext context, MyStoreController controller, int index) {
  // Valores padrão para os horários
  TimeOfDay horarioAbertura = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay horarioFechamento = TimeOfDay(hour: 18, minute: 0);
  
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Horário para ${controller.diasSemana[index]}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Horário de abertura'),
            subtitle: Text('${_formatTimeOfDayTo24Hour(horarioAbertura)}'),
            trailing: Icon(Icons.access_time),
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                cancelText: "Cancelar",
                confirmText: "Confirmar",
                hourLabelText: "Horas",
                minuteLabelText: "Minutos",
                helpText: "Insira o horário:",
                initialTime: horarioAbertura,
                initialEntryMode: TimePickerEntryMode.inputOnly,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: kPrimaryColor,
                        onPrimary: Colors.white,
                        onSurface: kPrimaryColor,
                      ),
                    ),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                          alwaysUse24HourFormat: true),
                      child: child!,
                    ),
                  );
                },
              );
              
              if (selectedTime != null) {
                horarioAbertura = selectedTime;
                (context as Element).markNeedsBuild();
              }
            },
          ),
          ListTile(
            title: Text('Horário de fechamento'),
            subtitle: Text('${_formatTimeOfDayTo24Hour(horarioFechamento)}'),
            trailing: Icon(Icons.access_time),
            onTap: () async {
              final selectedTime = await showTimePicker(
                context: context,
                cancelText: "Cancelar",
                confirmText: "Confirmar",
                hourLabelText: "Horas",
                minuteLabelText: "Minutos",
                helpText: "Insira o horário:",
                initialTime: horarioFechamento,
                initialEntryMode: TimePickerEntryMode.inputOnly,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: kPrimaryColor,
                        onPrimary: Colors.white,
                        onSurface: kPrimaryColor,
                      ),
                    ),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                          alwaysUse24HourFormat: true),
                      child: child!,
                    ),
                  );
                },
              );
              
              if (selectedTime != null) {
                horarioFechamento = selectedTime;
                (context as Element).markNeedsBuild();
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final formattedAbertura = _formatTimeOfDayTo24Hour(horarioAbertura);
            final formattedFechamento = _formatTimeOfDayTo24Hour(horarioFechamento);
            
            // Verificar se o horário de fechamento é maior que o de abertura
            if (_isClosingTimeInvalid(formattedAbertura, formattedFechamento)) {
              _showSnackbar(context, "O horário de fechamento deve ser maior que o de abertura.");
              return;
            }
            
            controller.definirHorarioDia(
              index, 
              formattedAbertura, 
              formattedFechamento
            );
            Navigator.pop(context);
          },
          child: Text('Confirmar'),
        ),
      ],
    ),
  );
}

bool _isClosingTimeInvalid(String abertura, String fechamento) {
  if (abertura.isEmpty || fechamento.isEmpty) return false;

  final aberturaParts = abertura.split(":").map(int.parse).toList();
  final fechamentoParts = fechamento.split(":").map(int.parse).toList();

  final aberturaMinutes = aberturaParts[0] * 60 + aberturaParts[1];
  final fechamentoMinutes = fechamentoParts[0] * 60 + fechamentoParts[1];

  return fechamentoMinutes <= aberturaMinutes;
}

void _showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    ),
  );
}
