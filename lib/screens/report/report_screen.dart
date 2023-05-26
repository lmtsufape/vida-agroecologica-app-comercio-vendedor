import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/navigator.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pedidos',
          style: kTitle2.copyWith(color: kPrimaryColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(
            kDefaultPadding - kSmallSize),
        height: size.height,
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return OrderCard();
            }),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pedido 010101',
              style: kBody3.copyWith(
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Cliente',
                  style: kCaption2.copyWith(
                      color: kTextButtonColor),
                ),
                Text('Nome do Cliente', style: kCaption1),
                IconButton(
                    onPressed: () {
                      navigatorKey.currentState!
                          .pushNamed(Screens.orderDetail);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kTextButtonColor,
                    ))
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Itens:',
                  style: kCaption2.copyWith(
                      color: kSuccessColor),
                ),
                Text('R\$55,62')
              ],
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Taxa de entrega:',
                  style: kCaption2.copyWith(
                      color: kTextButtonColor),
                ),
                Text('R\$7,62')
              ],
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total do pedido:',
                  style: kBody2,
                ),
                Text(
                  'R\$64,62',
                  style:
                  kBody2.copyWith(color: kDetailColor),
                )
              ],
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '10/10/2022',
                  style: kCaption2.copyWith(
                      color: kTextButtonColor),
                ),
                Container(
                  padding: const EdgeInsets.all(kTinySize),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(32),
                      color: kSuccessColor),
                  child: Text(
                    'Finalizado',
                    style: kCaption2.copyWith(
                        color: kBackgroundColor),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
