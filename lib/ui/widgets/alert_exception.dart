import 'package:flutter/material.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';

/// ------------------------------------------------------------
/// AlertException
/// ------------------------------------------------------------
///
/// Widget que muestra un mensaje de error basado en un
/// `CustomException`.
///
/// Consiste en un ícono de error y el mensaje asociado a la
/// excepción. Al tocar el área del widget, se cierra el diálogo
/// activo mediante `Navigator.pop()`.
///
/// ------------------------------------------------------------
/// Parámetros:
/// ------------------------------------------------------------
///
/// * [exception]
///   Instancia de `CustomException` que contiene el mensaje que
///   se mostrará en pantalla.
///
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
///
/// - Muestra un ícono de error centrado, con estilo basado en el
///   tema actual.
/// - Muestra el mensaje de la excepción en texto grande.
/// - Detecta un toque en cualquier parte del contenido para
///   cerrar el diálogo.
///
/// ------------------------------------------------------------
/// Método estático:
/// ------------------------------------------------------------
///
/// `showAlert` permite mostrar el widget dentro de un `AlertDialog`:
///
/// ```dart
/// AlertException.showAlert(
///   context,
///   exception: error,
/// );
/// ```
///
/// ------------------------------------------------------------
class AlertException extends StatelessWidget {
  const AlertException(this.exception, {super.key});

  final CustomException exception;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('alert-error_close-button'),
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Icon(
            Icons.cancel_outlined,
            color: context.getThemeData().colorScheme.error.withAlpha(60),
            size: 64,
          ),

          Text(
            exception.message,
            textAlign: TextAlign.center,
            style: context.getTextTheme().bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  static void showAlert(
    BuildContext context, {
    required CustomException exception,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: AlertException(exception),
        );
      },
    );
  }
}
