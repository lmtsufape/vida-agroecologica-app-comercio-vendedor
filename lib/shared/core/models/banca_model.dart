class BancaModel {
  int id;
  String nome;
  String descricao;
  String horarioAbertura;
  String horarioFechamento;
  int precoMin;
  String tipoEntrega;
  int feiraId;
  int agricultorId;

  BancaModel(
      this.nome,
      this.descricao,
      this.horarioAbertura,
      this.horarioFechamento,
      this.precoMin,
      this.tipoEntrega,
      this.id,
      this.feiraId,
      this.agricultorId);

  get getNome => nome;
  get getDescricao => descricao;
  get getHorarioAbertura => horarioAbertura;
  get getHorarioFechamento => horarioFechamento;
  get getPrecoMin => precoMin;
  get getTipoEntrega => tipoEntrega;
  get getFeiraId => feiraId;
  get getAgricultorId => agricultorId;
}
