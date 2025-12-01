class BancaModel {
  int id;
  String nome;
  String descricao;
  String horarioAbertura;
  String horarioFechamento;
  String precoMin;
  String pix;
  int feiraId;
  int agricultorId;
  Map<String, List<String>>? horariosFuncionamento;

  BancaModel(
      this.id,
      this.nome,
      this.descricao,
      this.horarioAbertura,
      this.horarioFechamento,
      this.precoMin,
      this.pix,
      this.feiraId,
      this.agricultorId,
      {this.horariosFuncionamento});

  get getId => id;
  get getNome => nome;
  get getDescricao => descricao;
  get getHorarioAbertura => horarioAbertura;
  get getHorarioFechamento => horarioFechamento;
  get getPrecoMin => precoMin;
  get getPix => pix;
  get getFeiraId => feiraId;
  get getAgricultorId => agricultorId;
  get getHorariosFuncionamento => horariosFuncionamento;
}