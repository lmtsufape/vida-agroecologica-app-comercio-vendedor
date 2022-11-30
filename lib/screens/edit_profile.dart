import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:thunderapp/components/buttons/primary_button.dart';
import 'package:thunderapp/components/forms/custom_text_form_field.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do perfil'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: Text('Editar foto')),
            ),
            Text(
              'Nome',
              style: kBody2,
            ),
            CustomTextFormField(
              label: 'João',
            ),
            Text(
              'Endereço',
              style: kBody2,
            ),
            CustomTextFormField(
              label: 'João',
            ),
            Text(
              'Forma de envio',
              style: kBody2,
            ),
            Row(
              children: [
                Checkbox(
                    value: false, onChanged: (value) {}),
                Text('Retirada'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: false, onChanged: (value) {}),
                Text('Entrega'),
              ],
            ),
            Text(
              'Forma de Pagamento',
              style: kBody2,
            ),
            Row(
              children: [
                Checkbox(
                    value: false, onChanged: (value) {}),
                Text('Dinheiro'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: false, onChanged: (value) {}),
                Text('PIX'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: false, onChanged: (value) {}),
                Text('Cartão'),
              ],
            ),
            Spacer(),
            PrimaryButton(text: 'Salvar', onPressed: () {})
          ],
        ),
      ),
    );
  }
}
