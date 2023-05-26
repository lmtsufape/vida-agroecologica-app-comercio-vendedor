import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class ElevatedButtonEditProduct extends StatelessWidget {
  const ElevatedButtonEditProduct({Key? key})
      : super(key: key);

  static ButtonStyle styleEditProduct =
      ElevatedButton.styleFrom(
    backgroundColor: kPrimaryColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: () {},
        style: styleEditProduct,
        child: Text(
          'Adicionar',
          style: TextStyle(
              color: kTextColor,
              fontSize: size.height * 0.024,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
