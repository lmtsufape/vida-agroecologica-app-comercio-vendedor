import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/buttons/secondary_button.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/screens/signin/sign_in_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/navigator.dart';

import '../../shared/constants/app_enums.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**Declare this variable to get the Media Query of the screen in the current context */
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => SignInController()),
        ],
        builder: (context, child) {
          return Consumer<SignInController>(
            builder: (context, controller, child) =>
                Scaffold(
              body: Stack(
                children: [
                  Container(
                    color: kPrimaryColor,
                    width: size.width,
                    padding: const EdgeInsets.all(
                        kDefaultPadding),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Eba, que bom que voltou',
                          textAlign: TextAlign.center,
                          style: kTitle1.copyWith(
                              color: kTextColor),
                        ),
                        SizedBox(
                          height: size.height * 0.3,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(
                          kDefaultPadding),
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius:
                              BorderRadius.circular(30)),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Para começar, que tal entrar na sua conta?',
                            style: kTitle2,
                            textAlign: TextAlign.center,
                          ),
                          const VerticalSpacerBox(
                              size: SpacerSize.huge),
                          controller.status ==
                                  SignInStatus.loading
                              ? const CircularProgressIndicator()
                              : PrimaryButton(
                                  text:
                                      'Continuar como Fulano',
                                  onPressed: () => navigatorKey
                                      .currentState!
                                      .pushReplacementNamed(
                                          Screens.signin)),
                          SizedBox(
                            width: size.width,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: <Widget>[
                                controller.errorMessage !=
                                        null
                                    ? Text(
                                        controller
                                            .errorMessage!,
                                        style: kCaption1,
                                      )
                                    : const SizedBox(),
                                const VerticalSpacerBox(
                                    size: SpacerSize.small),
                                SecondaryButton(
                                    text: 'Não sou fulano',
                                    onPressed: () {}),
                                const VerticalSpacerBox(
                                    size: SpacerSize.small),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: <Widget>[
                                    const Text(
                                        'Não possui conta?'),
                                    CustomTextButton(
                                        title: 'Crie aqui',
                                        onPressed: () {})
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
