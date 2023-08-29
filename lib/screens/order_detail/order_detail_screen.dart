import 'package:flutter/material.dart';
import 'package:thunderapp/components/buttons/cancel_button.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

import '../../shared/core/models/pedido_model.dart';

class OrderDetailScreen extends StatefulWidget {
  PedidoModel model;

  OrderDetailScreen(
    this.model, {
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      persistentFooterButtons: [
        SizedBox(
          child: Column(
            children: <Widget>[
              Divider(height: size.height * 0.02, color: Colors.transparent,),
              Text(
                'Confirmar pedido?',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: size.height * 0.020),
              ),
              Divider(height: size.height * 0.015, color: Colors.transparent,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: 168,
                    child: PrimaryButton(text: 'Confirmar', onPressed: () {}),
                  ),
                  SizedBox(
                    width: 168,
                    child: CancelButton(text: 'Cancelar', onPressed: () {}),
                  )
                ],
              )
            ],
          ),
        )
      ],
      appBar: AppBar(
        title: Text(
          'Detalhe pedido #0${widget.model.id}',
          style: kTitle2.copyWith(color: kPrimaryColor),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(kDefaultPadding - kSmallSize),
          height: size.height,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pedido #${widget.model.id.toString()}',
                        style: TextStyle(fontSize: size.height * 0.018),
                      ),
                      Text(
                        widget.model.dataPedido.toString(),
                        style: TextStyle(fontSize: size.height * 0.018, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Divider(height: size.height * 0.01, color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Cliente:',
                        style: kCaption2.copyWith(color: kTextButtonColor),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: Text(widget.model.consumidorId.toString(),
                            style: TextStyle(fontSize: size.height * 0.018, fontWeight: FontWeight.w700),),
                      ),
                      const SizedBox()
                    ],
                  ),
                  Divider(height: size.height * 0.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Forma de pagamento:',
                        style: kCaption2.copyWith(color: kTextButtonColor),
                      ),
                      Text(
                        widget.model.tipoPagamentoId.toString(),
                        style: TextStyle(fontSize: size.height * 0.018),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.image,
                            color: kPrimaryColor,
                          ))
                    ],
                  ),
                  Divider(height: size.height * 0.01, color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Tipo de entrega:',
                        style: kCaption2.copyWith(color: kTextButtonColor),
                      ),
                      Text(
                        widget.model.tipoEntrega.toString(),
                        style: TextStyle(fontSize: size.height * 0.018),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  Divider(height: size.height * 0.02, color: Colors.transparent,),
                  const InformationHolder(),
                  Divider(height: size.height * 0.02, color: Colors.transparent,),
                  ItensOrder(),
                  Divider(height: size.height * 0.03, color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Taxa de entrega',
                        style: TextStyle(fontSize: size.height * 0.018),
                      ),
                      Text(
                        'R\$ ${widget.model.taxaEntrega.toString()}',
                        style: TextStyle(fontSize: size.height * 0.018),
                      ),
                    ],
                  ),
                  Divider(height: size.height * 0.015, color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total do pedido', style: TextStyle(fontSize: size.height * 0.018)),
                      Text(
                        'R\$ ${widget.model.total.toString()}',
                        style: TextStyle(fontSize: size.height * 0.018, color: kPrimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class InformationHolder extends StatefulWidget {
  const InformationHolder({
    Key? key,
  }) : super(key: key);

  @override
  State<InformationHolder> createState() => _InformationHolderState();
}

class _InformationHolderState extends State<InformationHolder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Endereço:',
          style: TextStyle(fontSize: size.height * 0.018),
        ),
        Padding(
          padding: EdgeInsets.only(left: kHugeSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Rua professora Esmeralda Barros, 67'),
              Text('Boa Vista'),
              Text('Apartamento'),
              Text('Contato: (81) 99699-7476'),
            ],
          ),
        )
      ],
    );
  }
}

class ItensOrder extends StatefulWidget {
  const ItensOrder({super.key});

  @override
  State<ItensOrder> createState() => _ItensOrderState();
}

class _ItensOrderState extends State<ItensOrder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Itens:', style: TextStyle(fontSize: size.height * 0.018),),
        Divider(height: size.height * 0.02, color: Colors.transparent,),
        Column(
          children: [
            ListItens(),
            ListItens(),
            ListItens(),
            ListItens(),
          ],
        ),
      ],
    );
  }
}

class ListItens extends StatefulWidget {
  const ListItens({super.key});

  @override
  State<ListItens> createState() => _ListItensState();
}

class _ListItensState extends State<ListItens> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('2 unid x Pêra', style: TextStyle(fontSize: size.height * 0.018),),
        Text('R\$ 6,00', style: TextStyle(fontSize: size.height * 0.018),),
      ],
    );
  }
}


