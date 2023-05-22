import 'package:flutter/material.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/navigator.dart';

class DefaultAlertDialog extends StatelessWidget {
  const DefaultAlertDialog({Key? key, required this.title, required this.body, required this.cancelText, required this.onConfirm, required this.confirmText}) : super(key: key);
  final String title;
  final String body;
  final String cancelText;
  final String confirmText;
  final VoidCallback onConfirm;

  static ButtonStyle styleConfirm = ElevatedButton.styleFrom(
    backgroundColor: kSuccessColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  );

  static ButtonStyle styleCancel = ElevatedButton.styleFrom(
    backgroundColor: kErrorColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      child: AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        insetPadding:
        const EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        title: Center(
          child: Text(
            title,
            style: kBody2,
          ),
        ),
        content: Text(
          body,
          style: kCaption2,
        ),
        actions:<Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 28, bottom: 4),
                child: SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.040,
                  child: ElevatedButton(
                    style: styleConfirm,
                    onPressed: onConfirm,
                    child: Text(
                      confirmText,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: SizedBox(
                  width: size.width * 0.3,
                  height: size.height * 0.040,
                  child: ElevatedButton(
                    style: styleCancel,
                    onPressed: (() => navigatorKey.currentState!.pop()),
                    child: Text(
                      cancelText,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
