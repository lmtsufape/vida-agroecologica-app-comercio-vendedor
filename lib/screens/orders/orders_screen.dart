import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/orders/orders_controller.dart';
import 'package:thunderapp/screens/orders/orders_repository.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';
import 'package:thunderapp/shared/core/models/produto_pedido_model.dart';
import 'package:thunderapp/shared/core/navigator.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrdersRepository repository = OrdersRepository();

  Future<List<PedidoModel>>? orders;

  @override
  void initState() {
    orders = repository.getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<OrdersController>(
      init: OrdersController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Pedidos',
            style: kTitle2.copyWith(color: kPrimaryColor),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(kDefaultPadding - kSmallSize),
          height: size.height,
          child: ListView(
            children: controller.pedidos,
            ),
          ),
        ),
    );
  }
}

class OrderCard extends StatefulWidget {

  PedidoModel model;

  OrderCard(
    this.model,{
    Key? key,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pedido #${widget.model.id.toString()}',
              style: kBody3.copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Cliente',
                  style: kCaption2.copyWith(color: kTextButtonColor),
                ),
                Text(widget.model.consumidorId.toString(), style: kCaption1),
                IconButton(
                    onPressed: () {
                      navigatorKey.currentState!.pushNamed(Screens.orderDetail);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kTextButtonColor,
                    ))
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Itens:',
                  style: kCaption2.copyWith(color: kTextButtonColor),
                ),
                Text('R\$ ${widget.model.total}')
              ],
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Taxa de entrega:',
                  style: kCaption2.copyWith(color: kTextButtonColor),
                ),
                Text('R\$ ${widget.model.taxaEntrega}')
              ],
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Total do pedido:',
                  style: kBody2,
                ),
                Text(
                  'R\$ ${widget.model.subtotal}',
                  style: kBody2.copyWith(color: kDetailColor),
                )
              ],
            ),
            const VerticalSpacerBox(size: SpacerSize.small),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.model.dataPedido.toString(),
                  style: kCaption2.copyWith(color: kTextButtonColor),
                ),
                Container(
                  padding: const EdgeInsets.all(kTinySize),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: kAlertColor),
                  child: Text(
                    widget.model.status.toString(),
                    style: kCaption2.copyWith(color: kBackgroundColor),
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
