import 'package:flutter/material.dart';
import 'package:thunderapp/components/utils/horizontal_spacer_box.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../../shared/constants/app_enums.dart';

class TotalInfos extends StatelessWidget {
  const TotalInfos({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: size.width * 0.42,
          height: size.width * 0.165,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total de produtos',
                  style: TextStyle(
                      fontSize: size.height * 0.020,
                      fontWeight: FontWeight.w500),
                ),
                Divider(height: size.height * 0.006, color: Colors.transparent,),
                Text(
                  '0',
                  style: TextStyle(fontSize: size.height * 0.020, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.42,
          height: size.width * 0.165,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total de produtos',
                  style: TextStyle(
                      fontSize: size.height * 0.020,
                      fontWeight: FontWeight.w500),
                ),
                Divider(height: size.height * 0.006, color: Colors.transparent,),
                Text(
                  '0',
                  style: TextStyle(fontSize: size.height * 0.020, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
