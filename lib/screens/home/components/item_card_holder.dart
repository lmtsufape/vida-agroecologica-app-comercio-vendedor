import 'package:flutter/material.dart';

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

          children: <Widget>[
            Icon(
              icon,
              size: size.height * 0.1,
              color: kPrimaryColor,
            ),
            Divider(
              height: size.height * 0.001,
              color: Colors.transparent,
            ),
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
