import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thunderapp/assets/index.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/my_store/my_store_controller.dart';
import '../../../components/utils/horizontal_spacer_box.dart';
import '../../../shared/constants/app_enums.dart';
import '../../../shared/constants/style_constants.dart';

// ignore: must_be_immutable
class CircleImageProfile extends StatefulWidget {
  final MyStoreController controller;

  const CircleImageProfile(this.controller, {Key? key})
      : super(key: key);

  @override
  State<CircleImageProfile> createState() =>
      _CircleImageProfileState();
}

class _CircleImageProfileState
    extends State<CircleImageProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width * 0.24,
          height: size.height * 0.12,
          child: FloatingActionButton(
            backgroundColor: kBackgroundColor,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) =>
                    _bottomSheet(widget.controller),
              );
            },
            shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(100)),
            ),
            child: CircleAvatar(
              radius: 65,
              backgroundColor: kBackgroundColor,
              backgroundImage: widget
                          .controller.imagePath !=
                      null
                  ? NetworkImage(
                          widget.controller.imagePath!)
                      as ImageProvider<Object>
                  : (widget.controller.selectedImage != null
                      ? FileImage(
                          widget.controller.selectedImage!)
                      : const AssetImage(
                              Assets.logoAssociacao)
                          as ImageProvider<Object>),
              onBackgroundImageError: (_, __) {
                setState(() {
                  widget.controller.imagePath = null;
                });
              },
              child: widget.controller.imagePath == null &&
                      widget.controller.selectedImage ==
                          null
                  ? Icon(Icons.add_a_photo,
                      color: kPrimaryColor,
                      size: size.height * 0.035)
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Editar imagem",
            style: TextStyle(color: kPrimaryColor)),
      ],
    );
  }

  Widget _bottomSheet(MyStoreController controller) {
    return Container(
      height: 130.0,
      margin: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text("Escolha a foto da banca",
              style: TextStyle(fontSize: 20.0)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.camera, size: 30),
                onPressed: () =>
                    controller.selectImageCam(),
                label: const Text("Câmera",
                    style: TextStyle(fontSize: 23)),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.image, size: 30),
                onPressed: () => controller.selectImage(),
                label: const Text("Galeria",
                    style: TextStyle(fontSize: 23)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
