import 'package:dio/dio.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class MyStoreRepository {
  List<String> checkItems = [];
  FormData body = FormData.fromMap({});
  String formasPagamento = '';
  String? entrega;
  UserStorage userStorage = UserStorage();
  final Dio _dio = Dio();

  //Função para editar a banca
  Future<bool> editarBanca(
      String nome,
      String horarioAbertura,
      String horarioFechamento,
      String precoMin,
      bool? deliver,
      String? imgPath,
      List<bool> isSelected,
      BancaModel banca) async {
    //Verifica se o usuário quer entrega ou retirada na banca e seta a variável entrega
    if (deliver != null) {
      if (deliver == true) {
        entrega = 'ENTREGA';
      } else {
        entrega = 'RETIRADA';
      }
    }
    //Verifica se o usuário selecionou alguma forma de pagamento e seta a variável formasPagamento
    // a partir do checkItems, ele percorre o isSelected e verifica quais estão true,
    // e adiciona o valor de i + 1 no checkItems o i + 1 é o id da forma de pagamento, em seguida
    // ele percorre o checkItems e adiciona o valor de cada item no formasPagamento
    if (formasPagamento == '' && checkItems.isEmpty) {
      for (int i = 0; i < isSelected.length; i++) {
        if (isSelected[i] == true) {
          checkItems.add((i + 1).toString());
        }
      }
      for (int i = 0; i < checkItems.length; i++) {
        formasPagamento += '${checkItems[i]},';
      }
      //Remove a última vírgula da string
      formasPagamento = formasPagamento.substring(
          0, formasPagamento.length - 1);
    }
    String? userToken = await userStorage.getUserToken();
    try {
      //Se o usuário não selecionou uma imagem, ele envia o body sem a imagem para a API
      if (imgPath == null) {
        body = FormData.fromMap({
          "nome": nome.isEmpty
              ? banca.getNome.toString()
              : nome,
          "descricao": "loja",
          "horario_funcionamento": horarioAbertura.isEmpty
              ? banca.getHorarioAbertura.toString()
              : horarioAbertura,
          "horario_fechamento": horarioFechamento.isEmpty
              ? banca.getHorarioFechamento.toString()
              : horarioFechamento,
          "funcionamento": "1",
          "preco_minimo": precoMin.isEmpty
              ? banca.getPrecoMin.toString()
              : precoMin,
          "formas_pagamento": formasPagamento,
        });
      } else {
        body = FormData.fromMap({
          "nome": nome.isEmpty
              ? banca.getNome.toString()
              : nome,
          "descricao": "loja",
          "horario_funcionamento": horarioAbertura.isEmpty
              ? banca.getHorarioAbertura.toString()
              : '$horarioAbertura:00',
          "horario_fechamento": horarioFechamento.isEmpty
              ? banca.getHorarioFechamento.toString()
              : '$horarioFechamento:00',
          "funcionamento": "1",
          "preco_minimo": precoMin.isEmpty
              ? banca.getPrecoMin
              : precoMin,
          "imagem": await MultipartFile.fromFile(
            imgPath.toString(),
            filename: imgPath.split("\\").last,
          ),
          "formas_pagamento": formasPagamento,
        });
      }
      Response response =
          await _dio.post('$kBaseURL/bancas',
              options: Options(
                headers: {
                  "Authorization": "Bearer $userToken",
                  "Content-Type": "multipart/form-data",
                  "X-HTTP-Method-Override": "PUT"
                },
              ),
              data: body);
      if (response.statusCode == 200) {
        print('banca editada com sucesso');
        return true;
      } else {
        final errorMessage = response.data['errors'];
        print('Erro: $errorMessage');
        print(
            'erro ao editar a banca ${response.statusCode}}');
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        final dioError = e;
        if (dioError.response != null) {
          final errorMessage =
              dioError.response!.data['errors'];
          print('Erro: $errorMessage');
          print("Erro ${e.toString()}");
          return false;
        }
      }
    }
    return false;
  }
}
