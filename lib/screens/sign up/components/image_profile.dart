// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:thunderapp/screens/sign%20up/sign_up_controller.dart';

import '../../../components/utils/horizontal_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/constants/style_constants.dart';

class ImageProfile extends StatefulWidget {
  late SignUpController controller;

  ImageProfile(this.controller, {super.key});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: SizedBox(
        width: widthScreen * 0.4,
        height: heightScreen * 0.12,
        child: FloatingActionButton(
            heroTag: 'Photo',
            backgroundColor: kBackgroundColor,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: ((builder) =>
                      bottomSheet(widget.controller)));
            },
            child: Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  image: widget.controller.selectedImage !=
                          null
                      ? DecorationImage(
                          image: Image.file(
                          widget.controller.selectedImage!,
                          fit: BoxFit.fill,
                        ).image)
                      : null,
                ),
                child:
                    widget.controller.selectedImage == null
                        ? const Icon(
                            Icons.photo,
                            color: kSecondaryColor,
                            size: 50,
                          )
                        : null)),
      ),
    );
  }
}

Widget bottomSheet(SignUpController controller) {
  SignUpController _controller = controller;
  return Container(
    height: 100.0,
    width: 300.0,
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        const Text(
          "Escolha a foto",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  _controller.selectImageCam();
                },
                label: const Text("Camera"),
              ),
              const HorizontalSpacerBox(
                  size: SpacerSize.small),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  _controller.selectImage();
                },
                label: const Text("Galeria"),
              ),
            ])
      ],
    ),
  );
}
