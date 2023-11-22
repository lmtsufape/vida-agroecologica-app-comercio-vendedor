class TableProductsModel {
  int? id;
  String? nome;
  String? categoria;
  String? imagem;

  TableProductsModel(
      {this.id, this.nome, this.categoria, this.imagem});

  TableProductsModel.fromJson(Map<String, dynamic> json) {
    print(json['file']);
    id = json['id'];
    nome = json['nome'];
    categoria = json['categoria'];
    imagem = json['imagem'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'categoria': categoria,
        'imagem': imagem,
      };
}
