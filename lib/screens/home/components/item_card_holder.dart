import 'package:flutter/material.dart';

import '../../../components/utils/vertical_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/constants/style_constants.dart';

class ItemCardHolder extends StatelessWidget {
  const ItemCardHolder({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(
              icon,
              size: 84,
              color: kPrimaryColor,
            ),
            const VerticalSpacerBox(
                size: SpacerSize.medium),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.height * 0.022),
            )
          ],
        ),
      ),
    );
  }
}
