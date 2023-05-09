import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_controller.dart';
import 'package:thunderapp/screens/signin/sign_in_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../shared/constants/app_enums.dart';
import '../../shared/core/navigator.dart';
import '../start/start_controller.dart';
import 'components/info_first_screen.dart';
import 'components/info_second_screen.dart';
import 'components/info_third_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    /**Declare this variable to get the Media Query of the screen in the current context */
    Size size = MediaQuery.of(context).size;
    return GetBuilder<SignUpController>(
      init: SignUpController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(),
        backgroundColor: kPrimaryColor,
        body: Stack(
          children: [
            Container(
                width: size.width,
                margin: EdgeInsets.only(
                    top: size.height * 0.15),
                padding:
                    const EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius:
                        BorderRadius.circular(30)),
                child: Column(
                  children: [
                    const Spacer(),
                    Center(
                      child: Text(
                        controller.infoIndex == 0
                            ? 'Cadastro'
                            : controller.infoIndex == 1
                                ? 'Endereço'
                                : controller.infoIndex == 2
                                    ? 'Cadastro da Banca'
                                    : 'Cadastro da Banca',
                        style: kTitle1.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const VerticalSpacerBox(
                        size: SpacerSize.huge),
                    Form(
                      child: Column(
                          children: controller.infoIndex ==
                                  0
                              ? [
                                  InfoFirstScreen(
                                      controller),
                                ]
                              : controller.infoIndex == 1
                                  ? [
                                      InfoSecondScreen(
                                          controller),
                                    ]
                                  : controller.infoIndex ==
                                          2
                                      ? [
                                          InfoThirdScreen(
                                              controller),
                                        ]
                                      : [
                                          InfoThirdScreen(
                                              controller),
                                        ]),
                    ),
                    const VerticalSpacerBox(
                        size: SpacerSize.huge),
                    controller.screenState ==
                            ScreenState.loading
                        ? const CircularProgressIndicator()
                        : PrimaryButton(
                            text: 'Próximo',
                            onPressed: () {
                              controller.strength < 1 / 2
                                  ? () => null
                                  : controller.next();
                            }),
                    const VerticalSpacerBox(
                        size: SpacerSize.medium),
                    controller.infoIndex != 0
                        ? Center(
                            child: CustomTextButton(
                                onPressed: () =>
                                    controller.back(),
                                title: 'Anterior'),
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: <Widget>[
                          controller.errorMessage != null
                              ? Text(
                                  controller.errorMessage!,
                                  style: kCaption1,
                                )
                              : const SizedBox(),
                          const VerticalSpacerBox(
                              size: SpacerSize.small),
                          controller.infoIndex == 0
                              ? CustomTextButton(
                                  title: 'Já tenho conta',
                                  onPressed: () {
                                    navigatorKey
                                        .currentState!
                                        .pushReplacementNamed(
                                            Screens.signin);
                                  },
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Bem-vindo(a) ao App Bonito Produtor',
                    style: kTitle1.copyWith(
                        color: kBackgroundColor),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.75,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
