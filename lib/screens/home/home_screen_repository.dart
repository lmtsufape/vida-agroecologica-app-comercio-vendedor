// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import '../../shared/constants/app_text_constants.dart';

class HomeScreenRepository {
  final Dio _dio = Dio();

  Future<BancaModel?> getBancaPrefs(String? userToken, String? userId) async {
    print('userId: $userId');
    print('chegou aqui');

    try {
      Response response = await _dio.get(
          '$kBaseURL/bancas/agricultores/$userId',
          options: Options(headers: {"Authorization": "Bearer $userToken"}));
      if (response.statusCode == 200) {
        var bancaData = response.data["bancas"][0];
        
        // Parsear horarios_funcionamento se existir
        Map<String, List<String>>? horariosFuncionamento;
        if (bancaData["horarios_funcionamento"] != null) {
          horariosFuncionamento = {};
          (bancaData["horarios_funcionamento"] as Map<String, dynamic>).forEach((key, value) {
            if (value is List) {
              horariosFuncionamento![key] = value.map((e) => e.toString()).toList();
            }
          });
        }
        
        BancaModel bancaModel = BancaModel(
            bancaData["id"],
            bancaData["nome"].toString(),
            bancaData["descricao"].toString(),
            bancaData["horario_abertura"].toString(),
            bancaData["horario_fechamento"].toString(),
            bancaData["preco_minimo"].toString(),
            bancaData["pix"].toString(),
            bancaData["feira_id"],
            bancaData["agricultor_id"],
            horariosFuncionamento: horariosFuncionamento);
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