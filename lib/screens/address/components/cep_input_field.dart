import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class CepInputField extends StatelessWidget {
  final cepController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: cepController,
          decoration: const InputDecoration(isDense: true, labelText: 'CEP', hintText: '12.345-678'),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          keyboardType: TextInputType.number,
          validator: (cep) {
            if (cep.isEmpty)
              return 'Campo obrigatório';
            else if (cep.length != 10) return 'CEP inválido';
            return null;
          },
        ),
        RaisedButton(
          onPressed: () {
            if (Form.of(context).validate()) {
              context.read<CartManager>().getAddress(cepController.text);
            }
          },
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
          child: Text('Buscar CEP'),
        ),
      ],
    );
  }
}
