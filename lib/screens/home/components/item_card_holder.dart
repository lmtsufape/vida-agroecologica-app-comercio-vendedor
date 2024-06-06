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
      child: Container(
        width: size.width,
        height: size.height * 0.2,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(121, 116, 116, 116), 
              blurRadius: 10.0,
            ),
          ],
        ),
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
