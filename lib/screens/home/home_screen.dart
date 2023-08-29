import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/screens/list_products/list_products_screen.dart';
import 'package:thunderapp/screens/add_products/add_products_screen.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import '../../components/utils/horizontal_spacer_box.dart';
import '../my store/my_store_screen.dart';
import 'components/item_card_holder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Início',
                  style: kTitle2.copyWith(
                      color: kPrimaryColor),
                ),
                iconTheme: const IconThemeData(
                    color: kPrimaryColor),
              ),
              drawer: Drawer(
                  child: ListView(
                children: [
                  ListTile(
                    title: const Text('Sair'),
                    trailing: const Icon(
                      Icons.exit_to_app,
                      size: 20,
                      color: kPrimaryColor,
                    ),
                    onTap: () {},
                  )
                ],
              )),
              body: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(
                          kDefaultPadding),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: controller
                                        .bancaModel?.id !=
                                    null
                                ? null
                                : NetworkImage(
                                    '$kBaseURL/bancas/${controller.bancaModel?.id}/imagem',
                                    headers: {
                                        "Authorization":
                                            "Bearer ${controller.userToken}"
                                      }),
                            radius: 38,
                          ),
                          const HorizontalSpacerBox(
                              size: SpacerSize.small),
                          controller.bancaModel == null
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "Olá, ${controller.bancaModel?.nome}",
                                  style: TextStyle(
                                      fontSize:
                                          size.height *
                                              0.020,
                                      fontWeight:
                                          FontWeight.w500,
                                      color:
                                          kSecondaryColor),
                                ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                MyStoreScreen(
                                                    controller
                                                        .bancaModel)));
                                  },
                                  icon: Icon(
                                    Icons
                                        .mode_edit_outline_outlined,
                                    color: kPrimaryColor,
                                    size:
                                        size.height * 0.04,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons
                                        .notifications_none,
                                    color: kPrimaryColor,
                                    size:
                                        size.height * 0.04,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.width,
                      padding: const EdgeInsets.all(
                          kDefaultPadding),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        children: [
                          ItemCardHolder(
                            icon: Icons.storefront,
                            title: 'Produtos',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ListProductsScreen()));
                            },
                          ),
                          ItemCardHolder(
                            icon: Icons.list_alt_sharp,
                            title: 'Pedidos',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Screens.orders);
                            },
                          ),
                          ItemCardHolder(
                            icon: Icons.credit_card,
                            title: 'Pagamentos',
                            onTap: () {
                              Navigator.pushNamed(context,
                                  Screens.payments);
                            },
                          ),
                          ItemCardHolder(
                            icon: Icons.history_outlined,
                            title: 'Histórico',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Screens.report);
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: PrimaryButton(
                          text: 'Sair',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Screens.myStore);
                          }),
                    ),
                    const VerticalSpacerBox(
                        size: SpacerSize.huge)
                  ],
                ),
              ),
            ));
  }
}
