import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.onPressed})
      : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.add_box,
              size: size.height * 0.045,
              color: kPrimaryColor,
            )),
        Text(
          'Adicionar produto',
          style: TextStyle(
              fontSize: size.height * 0.018,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
