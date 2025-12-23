import 'package:flutter/material.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/ui/utils/account_utils.dart';
import 'package:flutter_facade/ui/utils/currency_utils.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';

/// ------------------------------------------------------------
/// AccountCard
/// ------------------------------------------------------------
///
/// Widget que muestra la información básica de una cuenta.
/// Incluye el tipo de cuenta, su identificador y el saldo
/// formateado.
///
/// Está diseñado para usarse en listas donde el usuario debe
/// seleccionar una cuenta. Puede mostrar un estado visual de
/// selección y ejecutar un callback cuando es tocado.
///
/// ------------------------------------------------------------
/// Parámetros:
/// ------------------------------------------------------------
///
/// * [account]
///   Instancia de `AccountModel` que contiene los datos a mostrar.
///
/// * [isSelected]
///   Indica si el widget debe mostrarse resaltado.
///
/// * [select]
///   Callback opcional que se ejecuta al presionar la tarjeta.
///
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
///
/// - Cambia el borde y el tintado cuando está seleccionado.
/// - Al tocarlo, ejecuta `select` si está definido.
/// - Utiliza utilidades de formato para mostrar información
///   del tipo de cuenta y su saldo.
///
/// ------------------------------------------------------------
/// Ejemplo:
/// ------------------------------------------------------------
///
/// ```dart
/// AccountCard(
///   account,
///   isSelected: isActive,
///   select: onTap,
/// )
/// ```
///
/// ------------------------------------------------------------

class AccountCard extends StatelessWidget {
  const AccountCard(
    this.account, {
    super.key,
    this.isSelected = false,
    this.select,
  });
  final AccountModel account;
  final bool isSelected;
  final VoidCallback? select;

  @override
  Widget build(BuildContext context) {
    final themeData = context.getThemeData();
    return Card.outlined(
      elevation: 2,
      surfaceTintColor: isSelected
          ? themeData.primaryColor.withValues(alpha: 0.0000001)
          : null,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected
              ? themeData.primaryColor
              : themeData.colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: select,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.type.titleValue),
                  Text(account.id),
                ],
              ),
              SizedBox(width: 8),
              Text(account.balance.getSimpleCurrencyFormat()),
            ],
          ),
        ),
      ),
    );
  }
}
