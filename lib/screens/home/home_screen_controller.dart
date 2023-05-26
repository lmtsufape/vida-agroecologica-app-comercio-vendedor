import 'package:get/get.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/user_storage.dart';

class HomeScreenController extends GetxController {
  UserStorage userStorage = UserStorage();
  HomeScreenRepository homeScreenRepository =
      HomeScreenRepository();
  String? userToken;
  BancaModel? bancaModel;
  String? userPapelId;

  Future getBancaPrefs() async {
    userToken = await userStorage.getUserToken();
    userPapelId = await userStorage.getPapelId();
    bancaModel = await homeScreenRepository.getBancaPrefs(
        userToken, userPapelId);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getBancaPrefs();
  }
}
