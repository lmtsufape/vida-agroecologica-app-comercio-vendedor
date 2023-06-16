import 'package:thunderapp/shared/core/models/transacoes_model.dart';

abstract class ITransacoesRepository  {
  Future<List<TransacoesModel>> getTransacoes();
}

class TransasoesRepository implements ITransacoesRepository {
  @override
  Future<List<TransacoesModel>> getTransacoes() {
    // TODO: implement getTransacoes
    throw UnimplementedError();
  }

}