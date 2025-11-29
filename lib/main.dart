import 'package:flutter/material.dart';
import 'package:flutter_facade/application/injection.dart';
import 'package:flutter_facade/ui/screen/success_screen.dart';
import 'package:flutter_facade/ui/screen/transfer_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  inject();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData.light();
    return MaterialApp(
      theme: themeData.copyWith(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          themeData.textTheme.copyWith(
            titleLarge: TextStyle(
              color: themeData.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      routes: {
        SuccessScreen.routeName: (context) => SuccessScreen(),
        TransferScreen.routeName: (context) => TransferScreen(),
      },
      initialRoute: TransferScreen.routeName,
      
    );
  }
}
