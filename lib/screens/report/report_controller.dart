import 'dart:developer';
import 'package:get/get.dart';
import 'package:thunderapp/screens/home/home_screen_repository.dart';
import 'package:thunderapp/screens/orders/orders_controller.dart';
import 'package:thunderapp/shared/core/models/banca_model.dart';
import 'package:thunderapp/shared/core/models/pedido_model.dart';
import '../../shared/core/user_storage.dart';
import 'report_repository.dart';
import 'report_screen.dart';

class ReportController extends GetxController {
  int quantPedidos = 0;
  BancaModel? bancaModel;
  HomeScreenRepository homeRepository = HomeScreenRepository();
  List<PedidoModel> orders = [];
  List<ReportCard> pedidos = [];
  late Future<List<dynamic>> orderData;
  ReportRepository repository = ReportRepository();
  List<PedidoModel> get getOrders => orders;
  var isLoading = true.obs;

  Future<List<ReportCard>> populateReportCard() async {
    isLoading(true); // Inicia o carregamento
    List<ReportCard> list = [];
    UserStorage userStorage = UserStorage();
    var token = await userStorage.getUserToken();
    var userId = await userStorage.getUserId();
    bancaModel = await homeRepository.getBancaPrefs(token, userId);
    var pedidos = await repository.getReports();

    quantPedidos = pedidos.length;

    for (int i = 0; i < pedidos.length; i++) {
      if (pedidos[i].status != "aguardando confirmação") {
        ReportCard card = ReportCard(pedidos[i], OrdersController());
        list.add(card);
      }
    }

    if (list.isNotEmpty) {
      update();
      isLoading(false); // Finaliza o carregamento
      return list;
    } else {
      log('CARD VAZIO');
      isLoading(false); // Finaliza o carregamento
      return list;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    pedidos = await populateReportCard();
    update();
  }
}
