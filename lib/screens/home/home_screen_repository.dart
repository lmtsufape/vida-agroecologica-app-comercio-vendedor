import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';

import '../../shared/constants/app_text_constants.dart';

class HomeScreenRepository {
  final Dio _dio = Dio();

  Future<BancaModel?> getBancaPrefs(
      String? userToken) async {
    log('chegou aqui');
    try {
      Response response = await _dio.get(
          '$kBaseURL/bancas/3',
          options: Options(headers: {
            "Authorization": "Bearer $userToken"
          }));
      if (response.statusCode == 200) {
        print(response.data["banca"]["nome"].toString());
        BancaModel bancaModel = BancaModel(
            response.data["banca"]["nome"].toString(),
            response.data["banca"]["descricao"].toString(),
            response.data["banca"]["horario_funcionamento"]
                .toString(),
            response.data["banca"]["horario_fechamento"]
                .toString(),
            response.data["banca"]["preco_min"].toString(),
            response.data["banca"]["tipo_entrega"]
                .toString(),
            response.data["banca"]["id"].toString());
        log('bancaModel: ${bancaModel.getNome}');
        return bancaModel;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
