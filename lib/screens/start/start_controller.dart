import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thunderapp/screens/start/start_repository.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

import '../home/home_screen_repository.dart';
import '../screens_index.dart';
import '../signin/sign_in_repository.dart';


class StartController extends GetxController {

  UserStorage userStorage = UserStorage();
  StartRepository startRepository = StartRepository();
  String? userToken;
  String? userId;
  String userName = 'teste';

  Future Start(BuildContext context) async {
    userId = await userStorage.getUserId();
    userToken = await userStorage.getUserToken();
    if(startRepository.vazia == 2){
      return 1;
    }
    return 0;
  }

  Future getUserName() async {
    userName = await userStorage.getUserName();
    update();
  }


  @override
  void onInit() {
    super.onInit();
    getUserName();
  }
}
