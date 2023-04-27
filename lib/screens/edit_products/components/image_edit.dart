import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import '../../../assets/index.dart';

class ImageEdit extends StatelessWidget {
  const ImageEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.center,
        height: size.width * 0.4,
        child: AspectRatio(
            aspectRatio: 1,
            child: Material(
                elevation: 3,
                shadowColor: Colors.black,
                child: Image.asset(Assets.example),
            ),
        ),
    );
  }
}
