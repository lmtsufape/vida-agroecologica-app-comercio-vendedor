import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/screens/signin/sign_in_controller.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/navigator.dart';

import '../../shared/constants/app_enums.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
              backgroundColor: kPrimaryColor,
              body: Stack(
                children: [
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(
                        top: size.height * 0.4),
                    padding: const EdgeInsets.all(
                        kDefaultPadding),
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius:
                            BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Center(
                          child: Text(
                            'Entrar',
                            style: kTitle1.copyWith(
                                fontWeight:
                                    FontWeight.bold),
                          ),
                        ),
                        const VerticalSpacerBox(
                            size: SpacerSize.huge),
                        CustomTextFormField(
                          hintText: 'Seu email',
                          icon: Icons.email,
                          controller:
                              controller.emailController,
                        ),
                        const VerticalSpacerBox(
                            size: SpacerSize.small),
                        CustomTextFormField(
                          hintText: 'Sua senha',
                          isPassword: true,
                          icon: Icons.lock,
                          controller:
                              controller.passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                  'Esqueceu a senha?')),
                        ),
                        const VerticalSpacerBox(
                            size: SpacerSize.medium),
                        controller.status ==
                                SignInStatus.loading
                            ? const Center(
                                child:
                                    CircularProgressIndicator())
                            : PrimaryButton(
                                text: 'Entrar',
                                onPressed: () {
                                  controller
                                      .signIn(context);
                                }),
                        const VerticalSpacerBox(
                            size: SpacerSize.large),
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
                                      style: kCaption1
                                          .copyWith(
                                              color:
                                                  kErrorColor),
                                    )
                                  : const SizedBox(),
                              const Text('ou'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                          FontAwesomeIcons
                                              .google),
                                      iconSize: 38),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                          FontAwesomeIcons
                                              .facebook),
                                      iconSize: 38)
                                ],
                              ),
                              const VerticalSpacerBox(
                                  size: SpacerSize.small),
                              CustomTextButton(
                                title: 'Cadastre-se',
                                onPressed: () =>
                                    navigatorKey
                                        .currentState!
                                        .pushNamed(
                                            Screens.signUp),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
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
                        height: size.height * 0.5,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
