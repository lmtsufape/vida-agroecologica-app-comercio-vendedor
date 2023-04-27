import 'package:flutter/material.dart';
import 'package:thunderapp/components/utils/horizontal_spacer_box.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../shared/constants/app_enums.dart';

class CardProducts extends StatelessWidget {
  const CardProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.066,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 14),
              child: Text(
                'Melancia',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.height * 0.024),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: Column(
                children: [
                  Text(
                    'Quantidade',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.016,
                        color: Colors.grey),
                  ),
                  Text('12',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.height * 0.024,
                          color: kPrimaryColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
