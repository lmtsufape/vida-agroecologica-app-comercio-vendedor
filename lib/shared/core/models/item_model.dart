class ItemModel {
  String createdAt;
  int id;
  String preco;
  int produtoId;
  int quantidade;
  String tipoUnidade;
  String updatedAt;
  int vendaId;

  ItemModel(
      {required this.createdAt,
      required this.id,
      required this.preco,
      required this.produtoId,
      required this.quantidade,
      required this.tipoUnidade,
      required this.updatedAt,
      required this.vendaId});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      createdAt: json['created_at'],
      id: json['id'],
      preco: json['preco'],
      produtoId: json['produto_id'],
      quantidade: json['quantidade'],
      tipoUnidade: json['tipo_unidade'],
      updatedAt: json['updated_at'],
      vendaId: json['venda_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['id'] = id;
    data['preco'] = preco;
    data['produto_id'] = produtoId;
    data['quantidade'] = quantidade;
    data['tipo_unidade'] = tipoUnidade;
    data['updated_at'] = updatedAt;
    data['venda_id'] = vendaId;
    return data;
  }
}
