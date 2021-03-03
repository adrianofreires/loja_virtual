import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/screens/checkout/components/card_text_field.dart';

class CardBack extends StatelessWidget {
  CardBack({this.cvvFocus, this.creditCard});
  final FocusNode cvvFocus;
  final CreditCard creditCard;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 16.0,
      child: Container(
        height: 200,
        color: Color(0xFF1b4852),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40.0,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            Row(
              children: [
                Expanded(
                    flex: 70,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      color: Colors.grey[500],
                      child: CardTextField(
                        initialValue: creditCard.securityCode,
                        hint: '123',
                        maxLength: 3,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputType: TextInputType.number,
                        textAlign: TextAlign.end,
                        validator: (cvv) {
                          if (cvv.length != 3) {
                            return 'Inválido';
                          }
                          return null;
                        },
                        focusNode: cvvFocus,
                        onSaved: creditCard.setCVV,
                      ),
                    )),
                Expanded(flex: 30, child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
