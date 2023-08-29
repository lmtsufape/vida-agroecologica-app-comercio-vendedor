import 'package:flutter/material.dart';
import 'package:thunderapp/screens/add_products/add_products_controller.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import '../../../components/forms/custom_currency_form_field.dart';

class SaleInfos extends StatefulWidget {
  final AddProductsController controller;

  const SaleInfos(this.controller, {Key? key}) : super(key: key);

  @override
  State<SaleInfos> createState() => _SaleInfosState();
}

class _SaleInfosState extends State<SaleInfos> {
  double profit = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preço de custo',
              style: TextStyle(
                  color: kTextButtonColor, fontSize: size.height * 0.017),
            ),
            Divider(
              height: size.height * 0.005,
            ),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.25,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                child: ClipPath(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black, width: 1)),
                    ),
                    alignment: Alignment.center,
                    child: CustomCurrencyTextFormField(
                      label: 'R\$ 2,62',
                      onChanged: (value) {
                        setState(() {
                          profit = widget.controller.changeProfit(
                              widget.controller.saleController.text,
                              widget.controller.costController.text);
                          widget.controller.setCostPrice();
                        });
                      },
                      inputFormatter: widget.controller.currencyFormatter,
                      controller: widget.controller.costController,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                'Preço de venda',
                style: TextStyle(
                    color: kTextButtonColor, fontSize: size.height * 0.017),
              ),
            ),
            Divider(
              height: size.height * 0.005,
            ),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.26,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                child: ClipPath(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CustomCurrencyTextFormField(
                      label: 'R\$ 4,62',
                      onChanged: (value) {
                        setState(() {
                          profit = widget.controller.changeProfit(
                              widget.controller.saleController.text,
                              widget.controller.costController.text);
                          widget.controller.setSalePrice();
                        });
                      },
                      inputFormatter: widget.controller.currencyFormatter,
                      controller: widget.controller.saleController,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lucro R\$',
              style: TextStyle(
                  color: kTextButtonColor, fontSize: size.height * 0.017),
            ),
            Divider(height: size.height * 0.005),
            SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.25,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ClipPath(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1))),
                    alignment: Alignment.center,
                    child: Text(
                      profit.toStringAsPrecision(4),
                      style: TextStyle(
                        fontSize: size.height * 0.017,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
