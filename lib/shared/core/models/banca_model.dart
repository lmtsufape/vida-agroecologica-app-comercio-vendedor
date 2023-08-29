class BancaModel {
  int id;
  String nome;
  String descricao;
  String horarioAbertura;
  String horarioFechamento;
  int precoMin;
  int feiraId;
  int agricultorId;

  BancaModel(
      this.id,
      this.nome,
      this.descricao,
      this.horarioAbertura,
      this.horarioFechamento,
      this.precoMin,
      this.feiraId,
      this.agricultorId);

  get getId => id;
  get getNome => nome;
  get getDescricao => descricao;
  get getHorarioAbertura => horarioAbertura;
  get getHorarioFechamento => horarioFechamento;
  get getPrecoMin => precoMin;
  get getFeiraId => feiraId;
  get getAgricultorId => agricultorId;
}
