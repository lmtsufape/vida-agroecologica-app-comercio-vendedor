import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thunderapp/components/utils/vertical_spacer_box.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'package:thunderapp/shared/core/http/http_client.dart';
import 'package:thunderapp/shared/core/navigator.dart';
import 'package:thunderapp/shared/core/repositories/transacoes_repository.dart';

import 'package:thunderapp/shared/core/store/transacao_store.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TransacaoStore store = TransacaoStore(
    repository: TransasoesRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getTransacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relatórios',
          style: kTitle2.copyWith(color: kPrimaryColor),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge(
            [store.isLoading, store.state, store.erro]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator());
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: SingleChildScrollView(
                child: Text(
                  store.erro.value,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (store.state.value.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum item na lista',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return TransactionListWidget(store: store);
          }
        },
      ),
    );
  }
}

class TransactionListWidget extends StatelessWidget {
  final TransacaoStore store;

  const TransactionListWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 32),
      padding: const EdgeInsets.all(16),
      itemCount: store.state.value.length,
      itemBuilder: (_, index) {
        final item = store.state.value[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pedido ${item.id}',
                  style: kBody3.copyWith(
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Cliente',
                      style: kCaption2.copyWith(
                          color: kTextButtonColor),
                    ),

                    Text('${item.consumidor_id}', style: kCaption1),
                    IconButton(
                        onPressed: () {
                          navigatorKey.currentState!
                              .pushNamed(Screens.orderDetail);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kTextButtonColor,
                        ))
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Itens:',
                      style: kCaption2.copyWith(
                          color: kTextButtonColor),
                    ),
                    Text('R\$${item.subtotal}')
                  ],
                ),
                const VerticalSpacerBox(size: SpacerSize.small),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Taxa de entrega:',
                      style: kCaption2.copyWith(
                          color: kTextButtonColor),
                    ),
                    Text('R\$${item.taxa_entrega}')
                  ],
                ),
                const VerticalSpacerBox(size: SpacerSize.small),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Total do pedido:',
                      style: kBody2,
                    ),
                    Text(
                      'R\$${item.total}',
                      style: kBody2.copyWith(color: kDetailColor),
                    )
                  ],
                ),
                const VerticalSpacerBox(size: SpacerSize.small),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(item.data_pedido)),
                      style: kCaption2.copyWith(
                          color: kTextButtonColor),
                    ),
                    Container(
                      padding: const EdgeInsets.all(kTinySize),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(32),
                          color: kAlertColor),
                      child: Text(
                        item.status,
                        style: kCaption2.copyWith(
                            color: kBackgroundColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

