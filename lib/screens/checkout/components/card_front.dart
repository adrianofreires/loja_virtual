import 'package:brasil_fields/brasil_fields.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/screens/checkout/components/card_text_field.dart';
import 'package:loja_virtual/screens/checkout/components/credit_card_flag.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardFront extends StatelessWidget {
  CardFront({this.nameFocus, this.dateFocus, this.numberFocus, this.finished, this.creditCard});
  final dateFormatter = MaskTextInputFormatter(mask: '!#/####', filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1]')});

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;
  final VoidCallback finished;
  final CreditCard creditCard;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 16.0,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        height: 200,
        color: Color(0xFF1b4852),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CardTextField(
                    initialValue: creditCard.number,
                    title: 'Número',
                    hint: '0000 0000 0000 0000',
                    textInputType: TextInputType.number,
                    bold: true,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, CartaoBancarioInputFormatter()],
                    validator: (number) {
                      if (number.length != 19)
                        return 'Inválido';
                      else if (detectCCType(number) == CreditCardType.unknown)
                        return 'Inválido';
                      else
                        return null;
                    },
                    onSubmitted: (_) {
                      dateFocus.requestFocus();
                    },
                    focusNode: numberFocus,
                    onSaved: creditCard.setNumber,
                  ),
                  CardTextField(
                    initialValue: creditCard.expirationDate,
                    title: 'Validade',
                    hint: '03/2025',
                    textInputType: TextInputType.number,
                    bold: true,
                    inputFormatters: [
                      dateFormatter,
                    ],
                    validator: (date) {
                      if (date.length != 7) return 'Inválido';
                      return null;
                    },
                    onSubmitted: (_) {
                      nameFocus.requestFocus();
                    },
                    focusNode: dateFocus,
                    onSaved: creditCard.setExpirationDate,
                  ),
                  CardTextField(
                    initialValue: creditCard.holder,
                    title: 'Títular',
                    hint: 'João da Silva',
                    textInputType: TextInputType.text,
                    bold: true,
                    validator: (name) {
                      if (name.isEmpty) return 'Inválido';
                      return null;
                    },
                    onSubmitted: (_) {
                      finished();
                    },
                    focusNode: nameFocus,
                    onSaved: creditCard.setHolder,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
