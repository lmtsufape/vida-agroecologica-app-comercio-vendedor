import 'package:flutter/material.dart';

import 'package:thunderapp/shared/core/models/produto_pedido_model.dart';



class PedidoModel extends ChangeNotifier{

  String? id;
  String? status;
  String? dataPedido;
  double? subtotal;
  double? taxaEntrega;
  double? total;
  String? consumidorId;
  String? produtorId;
  String? tipoPagamentoId;
  String? tipoEntrega;
  List<ProdutoPedidoModel>? itens;

  PedidoModel(
      this.id,
      this.status,
      this.dataPedido,
      this.subtotal,
      this.taxaEntrega,
      this.total,
      this.consumidorId,
      this.produtorId,
      this.tipoPagamentoId,
      this.tipoEntrega,
      this.itens,
  );

  get getId => id;
  get getStatus => status;
  get getDataPedido => dataPedido;
  get getSubtotal => subtotal;
  get getTaxaEntrega => taxaEntrega;
  get getTotal => total;
  get getConsumidorId => consumidorId;
  get getProdutorId => produtorId;
  get getTipoPagamentoId => tipoPagamentoId;
  get getTipoEntrega => tipoEntrega;
  get getItens => itens;
}