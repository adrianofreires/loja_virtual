// import 'package:credit_card_type_detector/credit_card_type_detector.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class CreditCardFlag extends StatelessWidget {
//   final String flagCard;
//   final double ccIconSize = 50.0;
//   CreditCardFlag({this.flagCard});
//
//   @override
//   Widget build(BuildContext context) {
//     IconData iconData;
//     switch (detectCCType(flagCard)) {
//       case CreditCardType.visa:
//         iconData = FontAwesomeIcons.ccVisa;
//         break;
//
//       case CreditCardType.amex:
//         iconData = FontAwesomeIcons.ccAmex;
//         break;
//
//       case CreditCardType.mastercard:
//         iconData = FontAwesomeIcons.ccMastercard;
//         break;
//
//       case CreditCardType.discover:
//         iconData = FontAwesomeIcons.ccDiscover;
//         break;
//
//       default:
//         iconData = FontAwesomeIcons.ccVisa;
//     }
//     return Icon(
//       iconData,
//       size: ccIconSize,
//     );
//   }
// }
