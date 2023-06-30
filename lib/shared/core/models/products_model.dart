class ProductsModel {
  String? nome;
  int? id;
  String? createdAt;
  String? updatedAt;
  String? descricao;
  String? tipoUnidade;
  int? estoque;
  double? preco;
  double? custo;
  int? disponivel;
  int? bancaId;
  int? produtoTabeladoId;

  ProductsModel({
    this.nome,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.descricao,
    this.tipoUnidade,
    this.estoque,
    this.preco,
    this.custo,
    this.disponivel,
    this.bancaId,
    this.produtoTabeladoId,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    descricao = json['descricao'];
    tipoUnidade = json['tipo_unidade'];
    estoque = json['estoque'];
    preco = json['preco'];
    custo = json['custo'];
    disponivel = json['disponivel'];
    bancaId = json['banca_id'];
    produtoTabeladoId = json['produto_tabelado_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['descricao'] = this.descricao;
    data['tipo_unidade'] = this.tipoUnidade;
    data['estoque'] = this.estoque;
    data['preco'] = this.preco;
    data['custo'] = this.custo;
    data['disponivel'] = this.disponivel;
    data['banca_id'] = this.bancaId;
    data['produto_tabelado_id'] = this.produtoTabeladoId;

    return data;
  }
}