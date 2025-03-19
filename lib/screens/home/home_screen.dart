import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:thunderapp/assets/index.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/screens/list_products/list_products_screen.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';
import '../../components/utils/horizontal_spacer_box.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../my_store/edit_store_screen.dart';
import '../my_store/my_store_controller.dart';
import 'components/item_card_holder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController controller = Get.put(HomeScreenController());

  @override
  void initState() {
    super.initState();
    controller.getBancaPrefs();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Início',
                style: kTitle2.copyWith(color: Colors.white),
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.getBancaPrefs(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 18, bottom: 10, left: 26, right: 26),
                  alignment: AlignmentDirectional.topStart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 38,
                        backgroundImage: const AssetImage(Assets.logoAssociacao),
                        foregroundImage: controller.bancaModel?.id == null
                            ? null
                            : NetworkImage(
                          '$kBaseURL/bancas/${controller.bancaModel?.id}/imagem?timestamp=${DateTime.now().millisecondsSinceEpoch}',
                          headers: {
                            "Authorization": "Bearer ${controller.userToken}"
                          },
                        ),
                      ),
                      const HorizontalSpacerBox(size: SpacerSize.small),
                      SizedBox(
                        width: size.width * 0.61,
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
                                            fontSize: size.height * 0.032,
                                            fontWeight: FontWeight.w500,
                                            color: kSecondaryColor),
                                      ),
                                    ),
                                  ),
                            IconButton(
                                onPressed: () {
                                  if (controller.bancaModel != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => EditStoreScreen(controller.bancaModel),
                                      ),
                                    );
                                  } else {
                                    // Talvez exibir uma mensagem de erro ou fazer algo para tratar o estado.
                                    print("BancaModel não encontrado!");
                                  }
                                },
                                icon: Icon(
                                  Icons.mode_edit_outline_outlined,
                                  color: kPrimaryColor,
                                  size: size.height * 0.04,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.height * 0.6,
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ItemCardHolder(
                            icon: Icons.storefront,
                            title: 'Produtos',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ListProductsScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 14.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.40,
                                height: size.height * 0.19,
                                child: ItemCardHolder(
                                  icon: Icons.list_alt_sharp,
                                  title: 'Pedidos',
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Screens.orders);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.40,
                                height: size.height * 0.19,
                                child: ItemCardHolder(
                                  icon: Icons.history_outlined,
                                  title: 'Histórico',
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Screens.report);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: PrimaryButton(
                        text: 'Sair',
                        onPressed: () async {
                          UserStorage userStorage = UserStorage();
                          userStorage.clearUserCredentials();
                          showDialog(
                            context: context,
                            builder: (context) => DefaultAlertDialog(
                              title: 'Confirmar',
                              body:
                                  'Você tem certeza que deseja sair do aplicativo?',
                              confirmText: 'Sim',
                              cancelText: 'Não',
                              onConfirm: () {
                                Navigator.popAndPushNamed(
                                    context, Screens.signin);
                              },
                              confirmColor: kSuccessColor,
                              cancelColor: kErrorColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
