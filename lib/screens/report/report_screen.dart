import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/order%20detail/order_detail_screen.dart';
import 'package:thunderapp/screens/orders/orders_controller.dart';
import 'package:thunderapp/screens/report/report_controller.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<ReportController>(
      init: ReportController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Histórico',
            style: kTitle2.copyWith(color: kPrimaryColor),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(
              kDefaultPadding - kSmallSize),
          height: size.height,
          child: ListView(
            children: controller.pedidos,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReportCard extends StatefulWidget {
  PedidoModel model;
  ReportController? controller;
  OrdersController ordersController;
  ReportCard(
    this.model,
    this.ordersController, {
    Key? key,
  }) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OrderDetailScreen(widget.model, widget.ordersController);
          })),
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Cor de fundo do Container
                  borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Cor da sombra com transparência
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPaddingCardPedido),
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: size.width * 0.4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pedido #${widget.model.id.toString()}',
                                          style: kBody3.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          height: size.height * 0.006,
                                          color: Colors.transparent,
                                        ),
                                        Text(
                                          'Cliente',
                                          style:
                                              kCaption2.copyWith(color: kTextButtonColor),
                                        ),
                                      ],
                                    ),
                                    const Text("",
                                      // widget.controller.fetchUserDetails(widget.model.consumidorId),
                                        style: kCaption1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return OrderDetailScreen(widget.model, widget.ordersController);
                                }),);
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: kPrimaryColor,
                                size: size.height * 0.05,
                              )),
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
                          Text(NumberFormat.simpleCurrency(locale:'pt-BR', decimalDigits: 2).format(widget.model.total))
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.medium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Taxa de entrega:',
                            style: kCaption2.copyWith(color: kTextButtonColor),
                          ),
                          Text(NumberFormat.simpleCurrency(locale:'pt-BR', decimalDigits: 2).format(widget.model.taxaEntrega))
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.medium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Total do pedido:',
                            style: kBody2,
                          ),
                          Text(
                            NumberFormat.simpleCurrency(locale:'pt-BR', decimalDigits: 2).format(widget.model.subtotal),
                            style: kBody2.copyWith(color: kDetailColor),
                          )
                        ],
                      ),
                      const VerticalSpacerBox(size: SpacerSize.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            DateFormat('dd/MM/yyyy').format(widget.model.dataPedido!),
                            style:
                            kCaption2.copyWith(color: kTextButtonColor, fontSize: 16, ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(kTinySize),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
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
              ),
            ),
          ),
        ),
        Divider(height: size.height * 0.01, color: Colors.transparent,),
      ],
    );
  }
}
