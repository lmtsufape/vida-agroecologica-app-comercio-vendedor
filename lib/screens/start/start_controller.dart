import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartController extends GetxController {
  String userName = 'teste';

  Future getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name')!;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getUserName();
  }
}
