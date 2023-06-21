class ProductsModel {
  Produto? produto;

  ProductsModel({this.produto});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    produto = json['produto'] != null
        ? Produto.fromJson(json['produto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{};
    if (produto != null) {
      data['produto'] = produto!.toJson();
    }
    return data;
  }
}

class Produto {
  String? descricao;
  String? tipoUnidade;
  int? estoque;
  double? preco;
  double? custo;
  int? bancaId;
  int? produtoTabeladoId;
  String? updatedAt;
  String? createdAt;
  int? id;
  ProdutoTabelado? produtoTabelado;
  Banca? banca;

  Produto(
      {this.descricao,
      this.tipoUnidade,
      this.estoque,
      this.preco,
      this.custo,
      this.bancaId,
      this.produtoTabeladoId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.produtoTabelado,
      this.banca});

  Produto.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    tipoUnidade = json['tipo_unidade'];
    estoque = json['estoque'];
    preco = json['preco'];
    custo = json['custo'];
    bancaId = json['banca_id'];
    produtoTabeladoId = json['produto_tabelado_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    produtoTabelado = json['produto_tabelado'] != null
        ? ProdutoTabelado.fromJson(
            json['produto_tabelado'])
        : null;
    banca = json['banca'] != null
        ? Banca.fromJson(json['banca'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{};
    data['descricao'] = descricao;
    data['tipo_unidade'] = tipoUnidade;
    data['estoque'] = estoque;
    data['preco'] = preco;
    data['custo'] = custo;
    data['banca_id'] = bancaId;
    data['produto_tabelado_id'] = produtoTabeladoId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    if (produtoTabelado != null) {
      data['produto_tabelado'] =
          produtoTabelado!.toJson();
    }
    if (banca != null) {
      data['banca'] = banca!.toJson();
    }
    return data;
  }
}

class ProdutoTabelado {
  int? id;
  String? nome;
  // ignore: prefer_void_to_null
  Null categoria;
  String? createdAt;
  String? updatedAt;

  ProdutoTabelado(
      {this.id,
      this.nome,
      this.categoria,
      this.createdAt,
      this.updatedAt});

  ProdutoTabelado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    categoria = json['categoria'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['categoria'] = categoria;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Banca {
  int? id;
  String? nome;
  String? descricao;
  String? horarioFuncionamento;
  String? horarioFechamento;
  int? funcionamento;
  int? precoMinimo;
  String? tipoEntrega;

  Banca(
      {this.id,
      this.nome,
      this.descricao,
      this.horarioFuncionamento,
      this.horarioFechamento,
      this.funcionamento,
      this.precoMinimo,
      this.tipoEntrega});

  Banca.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    horarioFuncionamento = json['horario_funcionamento'];
    horarioFechamento = json['horario_fechamento'];
    funcionamento = json['funcionamento'];
    precoMinimo = json['preco_minimo'];
    tipoEntrega = json['tipo_entrega'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['horario_funcionamento'] =
        horarioFuncionamento;
    data['horario_fechamento'] = horarioFechamento;
    data['funcionamento'] = funcionamento;
    data['preco_minimo'] = precoMinimo;
    data['tipo_entrega'] = tipoEntrega;
    return data;
  }
}
