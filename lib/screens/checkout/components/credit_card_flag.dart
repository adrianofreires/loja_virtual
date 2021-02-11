// import 'package:credit_card_type_detector/credit_card_type_detector.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class CreditCardFlag extends StatelessWidget {
//   final String flagCard;
//   CreditCardFlag({this.flagCard});
//
//   Function showFlag(){
//     double ccIconSize = 50.0;
//     Icon icon;
//     switch (detectCCType(flagCard)) {
//       case CreditCardType.visa:
//         icon = Icon(
//           FontAwesomeIcons.ccVisa,
//           size: ccIconSize,
//           color: Color(0xffffffff),
//         );
//         break;
//
//       case CreditCardType.amex:
//         icon = Icon(
//           FontAwesomeIcons.ccAmex,
//           size: ccIconSize,
//           color: Color(0xffffffff),
//         );
//         break;
//
//       case CreditCardType.mastercard:
//         icon = Icon(
//           FontAwesomeIcons.ccMastercard,
//           size: ccIconSize,
//           color: Color(0xffffffff),
//         );
//         break;
//
//       case CreditCardType.discover:
//         icon = Icon(
//           FontAwesomeIcons.ccDiscover,
//           size: ccIconSize,
//           color: Color(0xffffffff),
//         );
//         break;
//
//       default:
//         icon = Icon(
//           FontAwesomeIcons.ccVisa,
//           size: ccIconSize,
//           color: Color(0x00000000),
//         );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//   return showFlag;
//   }
//
// }
