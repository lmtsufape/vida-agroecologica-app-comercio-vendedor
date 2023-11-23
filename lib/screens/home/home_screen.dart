import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:thunderapp/shared/core/user_storage.dart';
import '../../components/utils/horizontal_spacer_box.dart';
import '../my store/edit_store_screen.dart';
import 'components/item_card_holder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Início',
                    style: kTitle2.copyWith(
                        color: kPrimaryColor),
                  ),
                ),
                iconTheme: const IconThemeData(
                    color: kPrimaryColor),
              ),
              body: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 18, bottom: 18, left: 26, right: 26),
                      alignment: AlignmentDirectional.topStart,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: controller
                                        .bancaModel?.id ==
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

                          SizedBox(
                            width: size.width *  0.61,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                controller.bancaModel == null
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Container(
                                      width: size.width * 0.38,
                                      alignment: AlignmentDirectional.topStart,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                            "Olá, ${controller.bancaModel?.nome}",
                                            style: TextStyle(
                                                fontSize:
                                                    size.height *
                                                        0.032,
                                                fontWeight:
                                                    FontWeight.w500,
                                                color:
                                                    kSecondaryColor),
                                          ),
                                      ),
                                    ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  EditStoreScreen(
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
                              ],
                            ),

                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 0.6,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15),
                      child: PrimaryButton(
                          text: 'Sair',
                          onPressed: () async {
                            UserStorage userStorage =
                                UserStorage();
                            userStorage
                                .clearUserCredentials();
                            Navigator.popAndPushNamed(
                                context, Screens.signin);
                          }),
                    ),
                    Divider(height: size.height * 0.02, color: Colors.transparent,)
                  ],
                ),
              ),
            ));
  }
}
