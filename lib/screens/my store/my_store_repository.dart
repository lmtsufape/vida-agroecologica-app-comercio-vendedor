import 'dart:developer';

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
      String? imgPath,
      List<bool> isSelected,
      BancaModel banca) async {

    //Verifica se o usuário quer entrega ou retirada na banca e seta a variável entrega

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
    print(banca.getPrecoMin);
    String precoMinimo = banca.getPrecoMin.toString();
    const find = "R\$";
    const replace = "";
    var pMinimo = precoMin.replaceAll(find, replace);
    var preMinimo = pMinimo.replaceAll(",", ".");

    try {
      //Se o usuário não selecionou uma imagem, ele envia o body sem a imagem para a API
      if (imgPath == null) {
        body = FormData.fromMap({
          "nome": nome.isEmpty
              ? banca.getNome.toString()
              : nome,
          "descricao": "loja",
          "horario_abertura": horarioAbertura.isEmpty
              ? banca.getHorarioAbertura.toString()
              : horarioAbertura,
          "horario_fechamento": horarioFechamento.isEmpty
              ? banca.getHorarioFechamento.toString()
              : horarioFechamento,
          "preco_minimo": precoMin.isEmpty
              ? banca.getPrecoMin.toString()
              : preMinimo,
          "formas_pagamento": formasPagamento,
          "bairro entrega": "1=>4.50"
        });
      } else {
        body = FormData.fromMap({
          "nome": nome.isEmpty
              ? banca.getNome.toString()
              : nome,
          "descricao": "loja",
          "horario_abertura": horarioAbertura.isEmpty
              ? banca.getHorarioAbertura.toString()
              : horarioAbertura,
          "horario_fechamento": horarioFechamento.isEmpty
              ? banca.getHorarioFechamento.toString()
              : horarioFechamento,
          "preco_minimo": precoMin.isEmpty
              ? banca.getPrecoMin
              : preMinimo,
          "imagem": await MultipartFile.fromFile(
            imgPath.toString(),
            filename: imgPath.split("\\").last,
          ),
          "formas pagamento": formasPagamento,
          "bairro entrega": "1=>4.50"
        });
      }
      Response response =
          await _dio.post('$kBaseURL/bancas/${banca.getId}',
              options: Options(
                headers: {
                  "Authorization": "Bearer $userToken",
                  "Content-Type": "multipart/form-data",
                  "X-HTTP-Method-Override": "PATCH"
                },
              ),
              data: body);
      if (response.statusCode == 200) {
        print('banca editada com sucesso');
        print(body);
        return true;
      } else {
        final errorMessage = response.data['errors'];
        print('Erro: $errorMessage');
        print(
            'erro ao editar a banca ${response.statusCode}}');
        print(body);
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
          print(body);
          return false;
        }
      }
    }
    print(body);
    return false;
  }

  Future<bool> adicionarBanca(
      String nome,
      String horarioAbertura,
      String horarioFechamento,
      String precoMin,
      String? imgPath,
      List<bool> isSelected) async {
    const find = "R\$";
    const replace = "";
    var pMinimo = precoMin.replaceAll(find, replace);
    var preMinimo = pMinimo.replaceAll(",", ".");

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
    String? userId = await userStorage.getUserId();
    try {
      body = FormData.fromMap({
        "nome": nome,
        "descricao": "loja",
        "horario_abertura": horarioAbertura,
        "horario_fechamento": horarioFechamento,
        "preco_minimo": preMinimo,
        "imagem": await MultipartFile.fromFile(
          imgPath.toString(),
          filename: imgPath!.split("\\").last,
        ),
        "formas pagamento": formasPagamento,
        "agricultor_id": userId,
        "feira_id": '1',
        "bairro entrega": '1=>3.50'
      });

      Response response = await _dio.post(
        '$kBaseURL/bancas',
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $userToken"
        }),
        data: body,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        log('cadastro da banca bem sucedida');
        // Mostrar o statusCode em um AlertDialog
        return true;
      } else {
        formasPagamento = '';
        checkItems = [];
        return false;
      }
    } catch (e) {
      formasPagamento = '';
      checkItems = [];
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
      return false;
    }
  }

  /*void _showAlertDialog(BuildContext context, String title, String content) {
    // Código para outras plataformas (como mobile)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }*/
}
