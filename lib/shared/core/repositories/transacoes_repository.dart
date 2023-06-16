import 'dart:convert';

import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/http/exceptions.dart';
import 'package:thunderapp/shared/core/http/http_client.dart';
import 'package:thunderapp/shared/core/models/transacoes_model.dart';

abstract class ITransacoesRepository  {
  Future<List<TransacoesModel>> getTransacoes();
}

class TransasoesRepository implements ITransacoesRepository {
  final IHttpClient client;

  TransasoesRepository({required this.client});


  @override
  Future<List<TransacoesModel>> getTransacoes() async{
    final response = await client.get(
      url: '$kBaseURL/vendas'
    );

    if (response.statusCode == 200){
      final List<TransacoesModel> transacoes = [];

      final body = jsonDecode(response.body);

      body['transações'].map( (item) {
        final TransacoesModel transacao = TransacoesModel.fromJson(item);
        transacoes.add(transacao);
      } ).toList();

      return transacoes;
    } else if (response.statusCode == 404){
      throw NotFundException('A url informada é invalida...');
    }else {
      throw Exception('Não foi possível carregar suas transaões...');
    }
  }

}