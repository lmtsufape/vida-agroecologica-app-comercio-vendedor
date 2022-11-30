import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/horizontal_spacer_box.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/edit_profile.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/navigator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => HomeScreenController(),
      builder: (context, child) =>
          Consumer<HomeScreenController>(
        builder: ((context, controller, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Gestão Agroecológica'),
              ),
              drawer: Drawer(
                  child: ListView(
                children: [
                  ListTile(
                    title: const Text('Sair'),
                    trailing: const Icon(Icons.exit_to_app),
                    onTap: () {},
                  )
                ],
              )),
              body: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 28.0, horizontal: 14),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 38,
                          ),
                          const HorizontalSpacerBox(
                              size: SpacerSize.small),
                          Text(
                            'Nome da Loja',
                            style: kBody2.copyWith(
                                color: kBackgroundColor),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                  return EditProfileScreen();
                                }));
                              },
                              icon: const Icon(Icons.edit,
                                  color: kBackgroundColor)),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            navigatorKey.currentState!
                                .pushNamed(Screens.orders);
                          },
                          title: const Text('Pedidos'),
                          leading: const Icon(Icons.list),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {},
                          title: const Text('Endereços'),
                          leading: const Icon(
                              Icons.location_on_sharp),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            navigatorKey.currentState!
                                .pushNamed(
                                    Screens.payments);
                          },
                          title: const Text('Pagamentos'),
                          leading:
                              const Icon(Icons.credit_card),
                        ),
                        const Divider(),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: PrimaryButton(
                          text: 'Sair', onPressed: () {}),
                    ),
                    const VerticalSpacerBox(
                        size: SpacerSize.huge)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
