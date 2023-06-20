class ProductsModel {
  Produto? produto;

  ProductsModel({this.produto});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    produto = json['produto'] != null
        ? new Produto.fromJson(json['produto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        new Map<String, dynamic>();
    if (this.produto != null) {
      data['produto'] = this.produto!.toJson();
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
        ? new ProdutoTabelado.fromJson(
            json['produto_tabelado'])
        : null;
    banca = json['banca'] != null
        ? new Banca.fromJson(json['banca'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['tipo_unidade'] = this.tipoUnidade;
    data['estoque'] = this.estoque;
    data['preco'] = this.preco;
    data['custo'] = this.custo;
    data['banca_id'] = this.bancaId;
    data['produto_tabelado_id'] = this.produtoTabeladoId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.produtoTabelado != null) {
      data['produto_tabelado'] =
          this.produtoTabelado!.toJson();
    }
    if (this.banca != null) {
      data['banca'] = this.banca!.toJson();
    }
    return data;
  }
}

class ProdutoTabelado {
  int? id;
  String? nome;
  Null? categoria;
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
        new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['categoria'] = this.categoria;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
        new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['horario_funcionamento'] =
        this.horarioFuncionamento;
    data['horario_fechamento'] = this.horarioFechamento;
    data['funcionamento'] = this.funcionamento;
    data['preco_minimo'] = this.precoMinimo;
    data['tipo_entrega'] = this.tipoEntrega;
    return data;
  }
}
