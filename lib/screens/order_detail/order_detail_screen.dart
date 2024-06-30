import 'package:flutter/material.dart';
import 'package:thunderapp/screens/order_detail_pedido/components/list_itens.dart';
import 'package:thunderapp/screens/order_detail_pedido/file_view_screen.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:intl/intl.dart';
import '../../shared/components/dialogs/default_alert_dialog.dart';
import '../../shared/core/models/pedido_model.dart';
import '../orders/orders_controller.dart';

// ignore: must_be_immutable
class OrderDetailScreen extends StatefulWidget {
  PedidoModel model;
  OrdersController controller;

  OrderDetailScreen(
    this.model,
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState
    extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    widget.model.consumidorName;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhe pedido #${widget.model.id}',
          style: kTitle2.copyWith(color: kPrimaryColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(kDefaultPadding - kSmallSize),
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
            color:Colors.white, // Cor de fundo do Container
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
            padding: const EdgeInsets.all(kDefaultPadding),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pedido #${widget.model.id.toString()}',
                      style: TextStyle(fontSize: size.height * 0.018),
                    ),
                    Text(DateFormat('dd/MM/yyyy').format(widget.model.dataPedido!),
                      style: TextStyle(
                          fontSize: size.height * 0.018,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Divider(
                  height: size.height * 0.01,
                  color: Colors.transparent,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Cliente:',
                    style: TextStyle(
                      fontSize: size.height * 0.022,
                      color: kTextButtonColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                      child: Text(widget.model.consumidorName!,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      )
                  ),
                  const SizedBox()
                ],
              ),
                Divider(
                  height: size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Forma de pagamento:',
                      style: TextStyle(
                        fontSize: size.height * 0.018,
                        color: kTextButtonColor,
                      ),
                    ),
                    Text(
                      widget.model.formaDePagamento!,
                      style: TextStyle(fontSize: size.height * 0.018),
                    ),
                    widget.model.formaDePagamento == 'pix'
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialogComprovante(
                                  title: 'Comprovante',
                                  body: 'Deseja visualizar o comprovante?',
                                  viewText: 'Visualizar',
                                  view: () async {
                                    await widget.controller.fetchComprovanteBytes(widget.model.id!);
                                    if (widget.controller.comprovanteBytes != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FileViewScreen(
                                            model: widget.model,
                                            controller: OrdersController(),
                                            comprovanteBytes: widget.controller.comprovanteBytes!,
                                            comprovanteType: widget.controller.comprovanteType!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                 
                                  viewColor: kSuccessColor,
                                  downloadColor:kErrorColor,
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.image,
                              color: kPrimaryColor,
                            ),
                          )
                        : const Text('')
                  ],
                ),
                Divider(
                  height: size.height * 0.01,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Tipo de entrega:',
                      style: TextStyle(
                          fontSize: size.height * 0.018,
                          color: kTextButtonColor),
                    ),
                    Text(widget.model.tipoEntrega.toString(),
                      style: TextStyle(fontSize: size.height * 0.018),
                    ),
                  ],
                ),
                Divider(
                  height: size.height * 0.02,
                  color: Colors.transparent,
                ),
                // const InformationHolder(),
                Divider(
                  height: size.height * 0.02,
                  color: Colors.transparent,
                ),
                Expanded(
                  child: ItensPedidoWidget(pedidoId: widget.model.id!),
                ),

                Divider(
                  height: size.height * 0.03,
                  color: Colors.transparent,
                ),
                // Row(
                //   mainAxisAlignment:
                //       MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       'Taxa de entrega',
                //       style: TextStyle(
                //           fontSize: size.height * 0.018),
                //     ),
                //     Text(
                //       NumberFormat.simpleCurrency(
                //               locale: 'pt-BR',
                //               decimalDigits: 2)
                //           .format(
                //               widget.model.taxaEntrega),
                //       style: TextStyle(
                //           fontSize: size.height * 0.018),
                //     ),
                //   ],
                // ),
                Divider(
                  height: size.height * 0.015,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total do pedido',
                      style: TextStyle(fontSize: size.height * 0.018),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(
                        locale: 'pt-BR',
                        decimalDigits: 2,
                      ).format(widget.model.subtotal),
                      style: TextStyle(
                        fontSize: size.height * 0.018,
                        color: kPrimaryColor,
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
