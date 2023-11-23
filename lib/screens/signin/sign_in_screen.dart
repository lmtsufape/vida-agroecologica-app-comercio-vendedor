import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/signin/sign_in_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../assets/index.dart';
import '../../shared/constants/app_enums.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SignInController()),
        ],
        builder: (context, child) {
          return Consumer<SignInController>(
            builder: (context, controller, child) =>
                Scaffold(
                  backgroundColor: kPrimaryColor,
                  body: CustomScrollView(
                    reverse: true,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Stack(
                          children: [
                            Container(
                              width: size.width,
                              height: size.height * 0.97,
                              margin: EdgeInsets.only(top: size.height * 0.03),
                              padding: const EdgeInsets.only(
                                  top: 30, left: 28, bottom: 0, right: 28),
                              decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Divider(height: size.height * 0.05,
                                color: Colors.transparent,),
                              Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Image.asset(
                                    Assets.logo,
                                    width: size.width * 0.5,
                                    color: kPrimaryColor,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    'VIDA AGROECOLÓGICA',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.height * 0.032,
                                        color: kPrimaryColor),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    '(aplicativo agricultor/a)',
                                    style: TextStyle(
                                      fontSize: size.height * 0.024,
                                      fontWeight: FontWeight.w500,
                                      color: kPrimaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                                height: size.height * 0.05,
                                color: Colors.transparent),
                            Center(
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.height * 0.032),
                              ),
                            ),
                            Divider(
                              height: size.height * 0.02,
                              color: Colors.transparent,
                            ),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'E-mail',
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: size.height * 0.018),
                                    ),
                                    IntrinsicWidth(
                                      stepWidth: size.width,
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        elevation: 0,
                                        child: ClipPath(
                                          child: Container(
                                            decoration:
                                            const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: CustomTextFormField(
                                              controller: controller
                                                  .emailController,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const VerticalSpacerBox(
                                    size: SpacerSize.small),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Senha',
                                      style: TextStyle(
                                          color: kSecondaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: size.height * 0.018),
                                    ),
                                    IntrinsicWidth(
                                      stepWidth: size.width,
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        elevation: 0,
                                        child: ClipPath(
                                          child: Container(
                                            decoration:
                                            const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black,
                                                    width: 1),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: CustomTextFormField(
                                              controller: controller
                                                  .passwordController,
                                              isPassword: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const VerticalSpacerBox(
                                    size: SpacerSize.medium),
                                controller.status == SignInStatus.loading
                                    ? const Center(
                                    child:
                                    CircularProgressIndicator())
                                    : PrimaryButton(
                                    text: 'Entrar',
                                    onPressed: () {
                                      controller.signIn(context);
                                    }),
                              ],
                            ),
                            const VerticalSpacerBox(size: SpacerSize.large),
                            SizedBox(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Desenvolvido por',
                                    style: TextStyle(
                                        fontSize: size.height * 0.018,
                                        fontWeight: FontWeight.w700,
                                        color: kSecondaryColor),
                                  ),
                                  Divider(
                                    height: size.height * 0.018,
                                    color: Colors.transparent,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.ufape,
                                        height: size.height * 0.09,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8),
                                        child: Image.asset(
                                          Assets.lmts,
                                          height: size.height * 0.06,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            /*SizedBox(
                              width: size.width,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  controller.errorMessage != null
                                      ? Text(
                                    controller.errorMessage!,
                                    style: kCaption1.copyWith(
                                        color: kErrorColor),
                                  )
                                      : const SizedBox(),
                                ],
                              ),
                            ),*/
                            const Spacer(),
                          ],
                        ),
                      ),
                      /*Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Image.asset(
                                  Assets.logo,
                                  width: size.width * 0.5,
                                  color: kBackgroundColor,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'VIDA AGROECOLÓGICA',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: size.height * 0.032,
                                      color: kBackgroundColor),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  '(aplicativo agricultor/a)',
                                  style: TextStyle(
                                    fontSize: size.height * 0.024,
                                    fontWeight: FontWeight.w500,
                                    color: kBackgroundColor,
                                  ),
                                )
                              ],
                            ),
                          ),*/
                      SizedBox(
                        height: size.height * 0.98,
                      ),
                    ],
                  ),
                ),
            ],
          ),)
          ,
          );
        });
  }
}
