import 'package:flutter/material.dart';
import 'package:flutter_facade/ui/screen/transfer_screen.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  static const String routeName = 'success_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            //Se navega a una versión nueva de la pantalla de transferencia para formatear valores antiguos
            Navigator.of(
              context,
            ).pushReplacementNamed(TransferScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16).copyWith(top: 64),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Hero(
                  tag: 'succes_animation',
                
                  child: Icon(
                    Icons.check_circle_outline_outlined,
                    color: context.getThemeData().primaryColor.withAlpha(100),
                    size: 120,
                  ),
                ),
                Text(
                  "Transacción exitosa",
                  textAlign: TextAlign.center,
                  style: context.getTextTheme().displayMedium,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                //Se navega a una versión nueva de la pantalla de transferencia para formatear valores antiguos
                Navigator.of(
                  context,
                ).pushReplacementNamed(TransferScreen.routeName);
              },
              child: Text("Presiona para volver"),
            ),
          ],
        ),
      ),
    );
  }
}
