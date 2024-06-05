import 'package:flutter/material.dart';
import 'package:thunderapp/assets/index.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/splash/splash_screen_controller.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final SplashScreenController _controller;
  late final AnimationController animController;
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2));
    _controller = SplashScreenController(context);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setController();
        stopController();
        _controller.initApplication(() {});
      },
    );
  }

  void setController() async {
    await animController.repeat();
  }

  void stopController() async {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        setState(
          () {
            opacity = 1;
          },
        );
        animController.stop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            margin: const EdgeInsets.only(bottom: 245),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Lottie.asset(
                //     width: 220,
                //     height: 220,
                //     controller: animController,
                //     Assets.introLottie,
                //     fit: BoxFit.fill),
                AnimatedOpacity(
                  duration:
                      const Duration(milliseconds: 200),
                  opacity: opacity,
                  child: Text(
                    'GESTÃO AGROECOLÓGICA BONITO',
                    textAlign: TextAlign.center,
                    style: kTitle1.copyWith(
                        color: kOnSurfaceColor,
                        fontSize: size.height * 0.038),
                  ),
                ),
                const VerticalSpacerBox(
                    size: SpacerSize.huge),
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Desenvolvido por:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const VerticalSpacerBox(
                      size: SpacerSize.small),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.ufape,
                        width: 100,
                      ),
                      const SizedBox(width: 20),
                      Image.asset(
                        Assets.lmts,
                        width: 150,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
