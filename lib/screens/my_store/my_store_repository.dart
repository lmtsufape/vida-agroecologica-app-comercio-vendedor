// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../../assets/index.dart';

class MyStoreRepository {
  List<String> checkItems = [];
  bool? entrega;
  FormData body = FormData.fromMap({});
  String formasPagamento = '';
  String role = 'Não entrou';
  UserStorage userStorage = UserStorage();
  final Dio _dio = Dio();

  Future<String> verificaRole() async {
    UserStorage userStorage = UserStorage();
    String? userToken = await userStorage.getUserToken();
    String? userId = await userStorage.getUserId();

    Response userResponse = await _dio.get(
      '$kBaseURL/users/$userId',
      options: Options(headers: {"Authorization": "Bearer $userToken"}),
    );

    List roles = userResponse.data['user']['roles'];
    int roleId = roles[0]['id'];
    String roleName = roles[0]['nome'];
    print('Role ID: $roleId');
    role = roleName;
    print('Role Name MyStoreRepository: $role');
    return role;
  }

  String gerarFormasPagamento(List<bool> isSelected) {
    List<String> selectedItems = [];
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i]) selectedItems.add((i + 1).toString());
    }
    return selectedItems.join(",");
  }

  // Função para editar a banca
  Future<bool> editarBanca(
      String nome,
      String horarioAbertura,
      String horarioFechamento,
      String precoMin,
      String? imgPath,
      List<bool> isSelected,
      String pix,
      bool? entrega,
      BancaModel banca) async {
    //Verifica se o usuário quer entrega ou retirada na banca e seta a variável entrega

    //Verifica se o usuário selecionou alguma forma de pagamento e seta a variável formasPagamento
    // a partir do checkItems, ele percorre o isSelected e verifica quais estão true,
    // e adiciona o valor de i + 1 no checkItems o i + 1 é o id da forma de pagamento, em seguida
    // ele percorre o checkItems e adiciona o valor de cada item no formasPagamento
    // Função para formatar o horário
    String formatTime(String time) {
      if (time.isNotEmpty && time.length >= 5) {
        return time.substring(0, 5);
      }
      return time;
    }

    String formasPagamento = gerarFormasPagamento(isSelected);

    if (formasPagamento == '' && checkItems.isEmpty) {
      for (int i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          checkItems.add((i + 1).toString());
        }
      }
      formasPagamento = checkItems.join(",");
    }

    String? userToken = await userStorage.getUserToken();
    // ignore: duplicate_ignore
    // ignore: avoid_print
    print(banca.getPrecoMin);

    String precoMinimo = banca.getPrecoMin.toString();
    const find = "R\$";
    const replace = "";
    var pMinimo = precoMin.replaceAll(find, replace);
    var preMinimo = pMinimo.replaceAll(",", ".");

    try {
      Map<String, dynamic> formDataMap = {
        "nome": nome.isEmpty ? banca.getNome.toString() : nome.toString(),
        "descricao": "loja",
        "horario_abertura": horarioAbertura.isEmpty
            ? formatTime(banca.getHorarioAbertura.toString())
            : formatTime(horarioAbertura),
        "horario_fechamento": horarioFechamento.isEmpty
            ? formatTime(banca.getHorarioFechamento.toString())
            : formatTime(horarioFechamento),
        "formas_pagamento": formasPagamento.isNotEmpty ? formasPagamento : '1',
        "entrega": entrega?.toString() ?? 'false',
        "pix": pix.isEmpty ? banca.getPix.toString() : pix.toString(),
        "bairro entrega": "1=>4.50"
      };

      if (precoMin.isNotEmpty) {
        const find = "R\$";
        const replace = "";
        var pMinimo = precoMin.replaceAll(find, replace);
        var preMinimo = pMinimo.replaceAll(",", ".");
        formDataMap["preco_minimo"] = preMinimo.toString();
      }

      if (imgPath != null) {
        formDataMap["imagem"] = await MultipartFile.fromFile(
          imgPath,
          filename: imgPath.split("\\").last,
        );
      }

      body = FormData.fromMap(formDataMap);

      Response response = await _dio.post(
        '$kBaseURL/bancas/${banca.getId}',
        options: Options(
          headers: {
            "Authorization": "Bearer $userToken",
            "Content-Type": "multipart/form-data",
            "X-HTTP-Method-Override": "PATCH"
          },
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        print('Banca editada com sucesso');
        print(body.fields);
        return true;
      } else {
        final errorMessage = response.data['errors'];
        print('Erro ao editar a banca: $errorMessage');
        print('Status Code: ${response.statusCode}');
        print(body.fields);
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          final errorMessage = e.response!.data['errors'];
          print('Erro: $errorMessage');
          print('Detalhes do Erro: ${e.response!.data}');
        }
      } else {
        print('Erro inesperado: $e');
      }
      return false;
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
      List<bool> isSelected,
      bool? entrega,
      String? pix) async {
    String? userToken = await userStorage.getUserToken();
    String? userId = await userStorage.getUserId();

    String formasPagamento = gerarFormasPagamento(isSelected);

    Map<String, dynamic> formDataMap = {
      "nome": nome,
      "descricao": 'loja',
      "horario_abertura": horarioAbertura,
      "horario_fechamento": horarioFechamento,
      "preco_minimo": precoMin.isNotEmpty ? precoMin : "0",
      "formas_pagamento": formasPagamento.isNotEmpty ? formasPagamento : '1',
      "entrega": entrega?.toString() ?? 'false',
      "pix": pix ?? '',
      "agricultor_id": userId.toString(),
      "feira_id": '1',
      "bairro_entrega": '1=>3.50'
    };

    // Se não houver imagem selecionada, usa a imagem padrão
    if (imgPath != null) {
      formDataMap["imagem"] = await MultipartFile.fromFile(imgPath);
    } else {
      File defaultImage = await _getAssetAsFile(Assets.logoAssociacao);
      formDataMap["imagem"] = await MultipartFile.fromFile(defaultImage.path);
    }



    body = FormData.fromMap(formDataMap);

    try {
      Response response = await _dio.post(
        '$kBaseURL/bancas',
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $userToken"
        }),
        data: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        log('Cadastro da banca bem-sucedido');
        return true;
      } else {
        print('Erro ao criar banca: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      if (e is DioError && e.response != null) {
        print("Erro ao adicionar banca: ${e.response?.data}");
      }
      print('Erro ao adicionar banca: $e');
      return false;
    }
  }

  Future<File> _getAssetAsFile(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();

    Directory? tempDir;
    try {
      tempDir = await getTemporaryDirectory(); // Pode lançar erro
    } catch (e) {
      print("Erro ao acessar getTemporaryDirectory: $e");
    }

    // Se getTemporaryDirectory() falhar, usa getApplicationDocumentsDirectory()
    tempDir ??= await getApplicationDocumentsDirectory();

    final tempFile = File('${tempDir.path}/default_image.png');
    await tempFile.writeAsBytes(bytes, flush: true);
    return tempFile;
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
