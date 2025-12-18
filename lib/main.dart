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
        SuccessScreen.routeName: (context) => SuccessScreen(
          onPopScreen: () {
            //Se navega a una versión nueva de la pantalla de transferencia para formatear valores antiguos
            Navigator.of(
              context,
            ).pushReplacementNamed(TransferScreen.routeName);
          },
        ),
        TransferScreen.routeName: (context) => TransferScreen(
          onTransferSuccess: () {
            Navigator.of(
              context,
            ).pushReplacementNamed(
              SuccessScreen.routeName,
            );
          },
        ),
      },
      initialRoute: TransferScreen.routeName,
    );
  }
}
