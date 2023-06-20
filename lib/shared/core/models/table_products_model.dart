class TableProductsModel {
  int? id;
  String? nome;
  String? categoria;
  String? createdAt;
  String? updatedAt;

  TableProductsModel(
      {this.id,
      this.nome,
      this.categoria,
      this.createdAt,
      this.updatedAt});

  TableProductsModel.fromJson(Map<String, dynamic> json) {
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
