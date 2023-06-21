import 'package:thunderapp/shared/core/models/item_model.dart';

class TransacoesModel {
  String comprovantePagamento;
  int consumidorId;
  String createdAt;
  String dataPedido;
  int formaPagamentoId;
  int id;
  List<ItemModel> itens;
  int produtorId;
  String status;
  String subtotal;
  String taxaEntrega;
  String total;
  String updatedAt;

  TransacoesModel(
      {required this.comprovantePagamento,
      required this.consumidorId,
      required this.createdAt,
      required this.dataPedido,
      required this.formaPagamentoId,
      required this.id,
      required this.itens,
      required this.produtorId,
      required this.status,
      required this.subtotal,
      required this.taxaEntrega,
      required this.total,
      required this.updatedAt});

  factory TransacoesModel.fromJson(
      Map<String, dynamic> json) {
    return TransacoesModel(
      comprovantePagamento: json['comprovante_pagamento'],
      consumidorId: json['consumidor_id'],
      createdAt: json['created_at'],
      dataPedido: json['data_pedido'],
      formaPagamentoId: json['forma_pagamento_id'],
      id: json['id'],
      itens: List<ItemModel>.from((json['itens'] as List)),
      produtorId: json['produtor_id'],
      status: json['status'],
      subtotal: json['subtotal'],
      taxaEntrega: json['taxa_entrega'],
      total: json['total'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['consumidor_id'] = consumidorId;
    data['created_at'] = createdAt;
    data['data_pedido'] = dataPedido;
    data['forma_pagamento_id'] = formaPagamentoId;
    data['id'] = id;
    data['produtor_id'] = produtorId;
    data['status'] = status;
    data['subtotal'] = subtotal;
    data['taxa_entrega'] = taxaEntrega;
    data['total'] = total;
    data['updated_at'] = updatedAt;
    data['comprovante_pagamento'] = comprovantePagamento;
    data['itens'] = itens.map((v) => v.toJson()).toList();
    return data;
  }
}
