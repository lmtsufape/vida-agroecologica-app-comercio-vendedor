import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';
import 'currency_format.dart';

class SaleInfos extends StatefulWidget {
  const SaleInfos({Key? key}) : super(key: key);

  @override
  State<SaleInfos> createState() => _SaleInfosState();
}

class _SaleInfosState extends State<SaleInfos> {
  CurrencyInputFormatter currency =
      CurrencyInputFormatter();
  TextEditingController costPrice = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  double profit = 0.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preço de custo',
                style: TextStyle(
                    color: kTextButtonColor,
                    fontSize: size.height * 0.017),
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.25,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6),
                      side: const BorderSide(
                          color: kTextButtonColor)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: costPrice,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'R\$ 2,70',
                                style: TextStyle(
                                    fontSize:
                                        size.height * 0.017,
                                    fontWeight:
                                        FontWeight.w700),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              costPrice.text = value;
                              profit = double.parse(
                                      salePrice.text) -
                                  double.parse(
                                      costPrice.text);
                            });
                          },
                          style: TextStyle(
                              fontSize: size.height * 0.017,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preço de venda',
                style: TextStyle(
                    color: kTextButtonColor,
                    fontSize: size.height * 0.017),
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.25,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6),
                      side: const BorderSide(
                          color: kTextButtonColor)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: salePrice,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                            label: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'R\$ 4,90',
                                style: TextStyle(
                                    fontSize:
                                        size.height * 0.017,
                                    fontWeight:
                                        FontWeight.w700),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              profit = double.parse(
                                      salePrice.text) -
                                  double.parse(
                                      costPrice.text);
                            });
                          },
                          style: TextStyle(
                              fontSize: size.height * 0.017,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
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
                    color: kTextButtonColor,
                    fontSize: size.height * 0.017),
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.25,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(6),
                      side: BorderSide(
                          color: kTextButtonColor)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '$profit',
                        style: TextStyle(
                            fontSize: size.height * 0.017,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
