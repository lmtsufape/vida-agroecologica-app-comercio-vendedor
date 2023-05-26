class BancaModel {
  String id;
  String nome;
  String descricao;
  String horarioAbertura;
  String horarioFechamento;
  String precoMin;
  String tipoEntrega;

  BancaModel(
      this.nome,
      this.descricao,
      this.horarioAbertura,
      this.horarioFechamento,
      this.precoMin,
      this.tipoEntrega,
      this.id);

  get getNome => nome;
  get getDescricao => descricao;
  get getHorarioAbertura => horarioAbertura;
  get getHorarioFechamento => horarioFechamento;
  get getPrecoMin => precoMin;
  get getTipoEntrega => tipoEntrega;
}
