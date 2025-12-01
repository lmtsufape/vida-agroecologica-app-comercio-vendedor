// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:thunderapp/screens/signin/components/sign_in_result.dart';
import 'package:thunderapp/shared/constants/app_text_constants.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class SignInRepository {
  final userStorage = UserStorage();
  String userId = "0";
  String userToken = "0";

  final _dio = Dio();

  Future<SignInResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$kBaseURL/sanctum/token',
        data: {'email': email, 'password': password, 'device_name': "PC"},
      );

      if (response.statusCode == 200) {
        if (await userStorage.userHasCredentials()) {
          await userStorage.clearUserCredentials();
        }

        userId = response.data['user']['id'].toString();
        userToken = response.data['token'].toString();

        await userStorage.saveUserCredentials(
          id: userId,
          nome: response.data['user']['name'].toString(),
          token: userToken,
          email: response.data['user']['email'].toString(),
        );

        try {
          Response response = await _dio.get(
            '$kBaseURL/bancas/agricultores/$userId',
            options: Options(headers: {"Authorization": "Bearer $userToken"}),
          );
          Response userResponse = await _dio.get(
            '$kBaseURL/users/$userId',
            options: Options(headers: {"Authorization": "Bearer $userToken"}),
          );

          if (response.statusCode == 200) {
            List roles = userResponse.data['user']['roles'];
            if (roles.isNotEmpty) {
              bool hasRole4 = roles.any((role) => role['id'] == 4);

              if (response.data["bancas"].isEmpty) {
                if (hasRole4) {
                  return SignInResult(SignInResultType.successNoBanca);
                } else {
                  return SignInResult(SignInResultType.unauthorized);
                }
              } else if (hasRole4) {
                return SignInResult(SignInResultType.success);
              } else {
                return SignInResult(SignInResultType.unauthorized);
              }
            }
          }
        } on DioException catch (e) {
          log('Erro ao buscar dados do usuário: ${e.message}');
          return _handleDioError(e);
        }

        return SignInResult(SignInResultType.success);
      }

      return SignInResult(SignInResultType.invalidCredentials);

    } on DioException catch (e) {
      log('DioException: ${e.type} - ${e.message}');
      return _handleDioError(e);
    } on SocketException {
      return SignInResult(
        SignInResultType.networkError,
        message: 'Sem conexão com a internet',
      );
    } catch (e) {
      log('Erro inesperado: $e');
      return SignInResult(
        SignInResultType.serverError,
        message: 'Erro inesperado. Tente novamente.',
      );
    }
  }

  SignInResult _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return SignInResult(
          SignInResultType.networkError,
          message: 'Conexão lenta. Verifique sua internet.',
        );

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;

        if (statusCode == 401 || statusCode == 422) {
          return SignInResult(SignInResultType.invalidCredentials);
        }

        if (statusCode == 500 || statusCode == 502 || statusCode == 503) {
          return SignInResult(
            SignInResultType.serverError,
            message: 'Servidor indisponível. Tente novamente mais tarde.',
          );
        }

        return SignInResult(
          SignInResultType.serverError,
          message: 'Erro no servidor (código $statusCode)',
        );

      case DioExceptionType.cancel:
        return SignInResult(
          SignInResultType.networkError,
          message: 'Requisição cancelada',
        );

      case DioExceptionType.connectionError:
        return SignInResult(
          SignInResultType.networkError,
          message: 'Sem conexão com a internet',
        );

      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return SignInResult(
            SignInResultType.networkError,
            message: 'Sem conexão com a internet',
          );
        }
        return SignInResult(
          SignInResultType.serverError,
          message: 'Erro de conexão',
        );

      default:
        return SignInResult(
          SignInResultType.serverError,
          message: 'Erro desconhecido',
        );
    }
  }
}