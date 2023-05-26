import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class StockAddProduct extends StatelessWidget {
  const StockAddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estoque atual',
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: size.height * 0.017),
        ),
        SizedBox(
          height: size.height * 0.06,
          width: size.width * 0.25,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(color: kTextButtonColor)),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  '25',
                  style: TextStyle(
                      fontSize: size.height * 0.017,
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor),
                )),
          ),
        ),
      ],
    );
  }
}
