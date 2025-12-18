import 'package:flutter/material.dart';
import 'package:flutter_facade/ui/screen/transfer_screen.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';

/// ------------------------------------------------------------
/// SuccessScreen
/// ------------------------------------------------------------
///
/// Pantalla que indica al usuario que una transferencia
/// se ha completado de manera exitosa.
///
/// Esta pantalla se muestra como destino final del flujo
/// de transferencia, una vez el `TransferCubit` emite un
/// estado exitoso.
///
/// ------------------------------------------------------------
/// Responsabilidad:
/// ------------------------------------------------------------
///
/// - Comunicar visualmente el éxito de la transacción.
/// - Ofrecer una forma clara de regresar al flujo de
///   transferencia.
/// - Reutilizar la animación `Hero` iniciada desde la
///   pantalla de transferencia.
///
/// ------------------------------------------------------------
/// Navegación:
/// ------------------------------------------------------------
///
/// * [routeName]
///   Identificador de la ruta utilizado para la navegación
///   mediante `Navigator`.
///
/// * Al presionar el botón de regresar o el ícono de volver,
///   se navega usando `pushReplacementNamed` hacia
///   [TransferScreen], creando una nueva instancia del flujo
///   para evitar estados previos.
///
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
///
/// - Muestra un ícono de confirmación con animación `Hero`.
/// - Presenta un mensaje de éxito centrado.
/// - Permite regresar al flujo de transferencia mediante:
///   * El botón de navegación en el `AppBar`.
///   * El botón de acción principal en el cuerpo de la vista.
///
/// ------------------------------------------------------------
/// Animaciones:
/// ------------------------------------------------------------
///
/// - Usa un `Hero` con el tag `succes_animation` para generar
///   una transición visual fluida desde la pantalla anterior.
///
/// ------------------------------------------------------------

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.onPopScreen,
  });
  final VoidCallback onPopScreen;

  static const String routeName = 'success_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: onPopScreen,
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
              onPressed: onPopScreen,
              child: Text("Presiona para volver"),
            ),
          ],
        ),
      ),
    );
  }
}
