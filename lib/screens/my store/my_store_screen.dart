import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/components/buttons/custom_text_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/horizontal_spacer_box.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/home/home_screen_controller.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class MyStoreScreen extends StatelessWidget {
  const MyStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => HomeScreenController(),
      builder: (context, child) =>
          Consumer<HomeScreenController>(
        builder: ((context, controller, child) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Minha loja',
                  style: kTitle2,
                ),
              ),
              body: Container(
                width: size.width,
                height: size.height,
                padding:
                    const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 28.0, horizontal: 14),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 38,
                          ),
                          const HorizontalSpacerBox(
                              size: SpacerSize.small),
                          Text('Nome da Loja',
                              style: kBody2),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit,
                                  color: kBackgroundColor)),
                        ],
                      ),
                    ),
                    // Expanded(
                    //     child: GridView.count(
                    //   crossAxisCount: 2,
                    //   children: [
                    //     ItemCardHolder(
                    //       icon: Icons.storefront,
                    //       title: 'Produtos',
                    //     ),
                    //     ItemCardHolder(
                    //       icon: Icons.list_alt_sharp,
                    //       title: 'Pedidos',
                    //     ),
                    //     ItemCardHolder(
                    //       icon: Icons.credit_card,
                    //       title: 'Pagamentos',
                    //     ),
                    //     ItemCardHolder(
                    //       icon: Icons.bar_chart_rounded,
                    //       title: 'Relatório',
                    //     ),
                    //   ],
                    // )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
