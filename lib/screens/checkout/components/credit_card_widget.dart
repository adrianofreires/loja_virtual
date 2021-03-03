import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:loja_virtual/models/credit_card.dart';
import 'package:loja_virtual/screens/checkout/components/card_back.dart';
import 'package:loja_virtual/screens/checkout/components/card_front.dart';

class CreditCardWidget extends StatefulWidget {
  final CreditCard creditCard;
  CreditCardWidget(this.creditCard);
  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();

  final FocusNode dateFocus = FocusNode();

  final FocusNode nameFocus = FocusNode();

  final FocusNode cvvFocus = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        actions: [
          KeyboardActionsItem(focusNode: numberFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: dateFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: nameFocus, toolbarButtons: [
            (_) {
              return GestureDetector(
                onTap: () {
                  cardKey.currentState.toggleCard();
                  cvvFocus.requestFocus();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text('Continuar'),
                ),
              );
            }
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      autoScroll: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FlipCard(
              key: cardKey,
              direction: FlipDirection.HORIZONTAL,
              speed: 700,
              flipOnTouch: false,
              front: CardFront(
                creditCard: widget.creditCard,
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                finished: () {
                  cardKey.currentState.toggleCard();
                  cvvFocus.requestFocus();
                },
              ),
              back: CardBack(
                creditCard: widget.creditCard,
                cvvFocus: cvvFocus,
              ),
            ),
            FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  cardKey.currentState.toggleCard();
                },
                textColor: Colors.white,
                child: const Text('Virar Cartão')),
          ],
        ),
      ),
    );
  }
}
