import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';

import '../../shared/constants/app_text_constants.dart';

class HomeScreenRepository {
  final Dio _dio = Dio();

  Future<BancaModel?> getBancaPrefs(
      String? userToken, String? userId) async {
    print('userId: $userId');
    print('chegou aqui');

    try {
      Response response = await _dio.get(
          '$kBaseURL/bancas/agricultores/$userId',
          options: Options(headers: {
            "Authorization": "Bearer $userToken"
          }));
      if (response.statusCode == 200) {
        BancaModel bancaModel = BancaModel(
            response.data["bancas"][0]["id"],
            response.data["bancas"][0]["nome"].toString(),
            response.data["bancas"][0]["descricao"]
                .toString(),
            response.data["bancas"][0]["horario_abertura"]
                .toString(),
            response.data["bancas"][0]["horario_fechamento"]
                .toString(),
            response.data["bancas"][0]["preco_minimo"].toString(),
            response.data["bancas"][0]["pix"].toString(),
            response.data["bancas"][0]["feira_id"],
            response.data["bancas"][0]["agricultor_id"]);
        log('bancaModel: ${bancaModel.getNome}');
        return bancaModel;
      } else {
        log('response.statuscode != 200');
        return null;
      }
    } catch (e) {
      log('Entrou no catch do get de bancas');
      log("$e");
      return null;
    }
  }
}
