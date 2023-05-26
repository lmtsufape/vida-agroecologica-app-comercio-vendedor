import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:thunderapp/screens/sign%20up/components/image_profile.dart';

import '../sign_up_controller.dart';

class InfoFourthScreen extends StatefulWidget {
  InfoFourthScreen(this.controller, {super.key});
  late SignUpController controller;
  @override
  State<InfoFourthScreen> createState() =>
      _InfoFourthScreenState();
}

class _InfoFourthScreenState
    extends State<InfoFourthScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: ImageProfile(widget.controller)),
      ],
    );
  }
}
