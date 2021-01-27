import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraria_news/modules/view/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('pt_BR', null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: ThemeData(
        primaryColor: Color(0xFF1e1e22),
        accentColor: Color(0xFFe82822),
        textTheme: GoogleFonts.interTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
