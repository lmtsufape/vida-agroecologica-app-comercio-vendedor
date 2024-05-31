// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:thunderapp/screens/order_detail_pedido/components/itens_order.dart';
// import 'package:thunderapp/screens/order_detail_pedido/file_view_screen.dart';
// import 'package:thunderapp/screens/orders/orders_controller.dart';
// import 'package:thunderapp/shared/components/dialogs/default_alert_dialog.dart';
// import 'package:thunderapp/shared/constants/app_number_constants.dart';
// import 'package:thunderapp/shared/constants/style_constants.dart';

// // ignore: must_be_immutable
// class BodyDetailScreen extends StatelessWidget {
//    BodyDetailScreen(
//     this.numberPedido,
//      this.dataPedido,
//      this.consumidorId,
//      this.formaPagamentoId,
//      this.controller,
//      this.comprovante,
//       {super.key});
//  String numberPedido;
//  DateTime dataPedido;
//  int consumidorId;
// OrdersController controller;
// int comprovante;
//  int formaPagamentoId;
//   @override
//   Widget build(BuildContext context) {
//         Size size = MediaQuery.of(context).size;

//     return Container(
//           padding: const EdgeInsets.all(kDefaultPadding - kSmallSize),
//           height: size.height,
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(kDefaultPadding),
//               child: ListView(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Pedido #${numberPedido.toString()}',
//                         style: TextStyle(fontSize: size.height * 0.018),
//                       ),
//                       Text(
//                         DateFormat('dd/MM/yyyy').format(dataPedido),
//                         style: TextStyle(
//                             fontSize: size.height * 0.018,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     height: size.height * 0.01,
//                     color: Colors.transparent,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         'Cliente:',
//                         style: TextStyle(
//                             fontSize: size.height * 0.022,
//                             color: kTextButtonColor),
//                       ),
//                        Padding(
//                         padding: const EdgeInsetsDirectional.only(start: 10),
//                         child: Text("$consumidorId",
//                             style: TextStyle(fontSize: size.height * 0.018, fontWeight: FontWeight.w700),),
//                       ),
//                       const SizedBox()
//                     ],
//                   ),
//                   Divider(
//                     height: size.height * 0.03,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         'Forma de pagamento:',
//                         style: TextStyle(
//                             fontSize: size.height * 0.018,
//                             color: kTextButtonColor),
//                       ),
//                       Text(
//                         formaPagamentoId == 1 ? "Pix" : "Dinheiro",
//                         style: TextStyle(fontSize: size.height * 0.018),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) => AlertDialogComprovante(
//                               title: 'Comprovante',
//                               body:
//                               'Você quer visualizar ou baixar o comprovante?',
//                               viewText: 'Visualizar',
//                               downloadText: 'Baixar',
//                               view: () async {
//                                 await controller
//                                     .fetchComprovanteBytes(comprovante!);
//                                 if (widget.controller.comprovanteBytes !=
//                                     null) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => FileViewScreen(
//                                         comprovanteBytes:
//                                             widget.controller.comprovanteBytes!,
//                                         comprovanteType:
//                                             widget.controller.comprovanteType!,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                               download: () async {
//                                 await widget.controller
//                                     .downloadComprovante(widget.model.id!);
//                                 if (widget.controller.downloadPath != null) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text(
//                                             'Comprovante baixado com sucesso!')),
//                                   );
//                                 }
//                               },
//                               viewColor: kSuccessColor,
//                               downloadColor: kErrorColor,
//                             ),
//                           );
//                         },
//                         icon: const Icon(
//                           Icons.image,
//                           color: kPrimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     height: size.height * 0.01,
//                     color: Colors.transparent,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         'Tipo de entrega:',
//                         style: TextStyle(
//                             fontSize: size.height * 0.018,
//                             color: kTextButtonColor),
//                       ),
//                       Text(
//                         widget.model.tipoEntrega.toString(),
//                         style: TextStyle(fontSize: size.height * 0.018),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     height: size.height * 0.02,
//                     color: Colors.transparent,
//                   ),
//                   // const InformationHolder(),
//                   Divider(
//                     height: size.height * 0.02,
//                     color: Colors.transparent,
//                   ),
//                   const ItensOrder(),
//                   Divider(
//                     height: size.height * 0.03,
//                     color: Colors.transparent,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         'Taxa de entrega',
//                         style: TextStyle(fontSize: size.height * 0.018),
//                       ),
//                       Text(
//                         NumberFormat.simpleCurrency(
//                                 locale: 'pt-BR', decimalDigits: 2)
//                             .format(widget.model.taxaEntrega),
//                         style: TextStyle(fontSize: size.height * 0.018),
//                       ),
//                     ],
//                   ),
//                   Divider(
//                     height: size.height * 0.015,
//                     color: Colors.transparent,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         'Total do pedido',
//                         style: TextStyle(fontSize: size.height * 0.018),
//                       ),
//                       Text(
//                         NumberFormat.simpleCurrency(
//                                 locale: 'pt-BR', decimalDigits: 2)
//                             .format(widget.model.subtotal),
//                         style: TextStyle(
//                             fontSize: size.height * 0.018,
//                             color: kPrimaryColor),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//   }
// }