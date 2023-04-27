import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class SaleInfos extends StatelessWidget {
  const SaleInfos({Key? key}) : super(key: key);

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
                    color: kTextButtonColor, fontSize: size.height * 0.017),
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.25,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: kTextButtonColor)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'R\$ 2,70',
                        style: TextStyle(fontSize: size.height * 0.017, fontWeight: FontWeight.w700),
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
                    color: kTextButtonColor, fontSize: size.height * 0.017),
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.25,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: kTextButtonColor)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'R\$ 4,90',
                        style: TextStyle(fontSize: size.height * 0.017, fontWeight: FontWeight.w700),
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
                    color: kTextButtonColor, fontSize: size.height * 0.017),
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.25,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: kTextButtonColor)),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'R\$ 2,20',
                        style: TextStyle(fontSize: size.height * 0.017, fontWeight: FontWeight.w700, color: kPrimaryColor),
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
