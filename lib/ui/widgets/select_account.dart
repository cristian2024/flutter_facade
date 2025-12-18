import 'package:flutter/material.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/ui/widgets/account_card.dart';

/// ------------------------------------------------------------
/// SelectAccount
/// ------------------------------------------------------------
///
/// Widget que muestra una lista horizontal de cuentas utilizando
/// `AccountCard`.
///
/// Permite seleccionar una cuenta y notificar la selección a
/// través de un callback. Está pensado para usarse en pantallas
/// donde el usuario debe elegir una cuenta entre varias opciones.
///
/// ------------------------------------------------------------
/// Parámetros:
/// ------------------------------------------------------------
///
/// * [accounts]
///   Lista de cuentas que se mostrarán.
///
/// * [selectedAccount]
///   Cuenta actualmente seleccionada. Se usa para resaltar su
///   tarjeta correspondiente.
///
/// * [onSelectAccount]
///   Función que se ejecuta cuando el usuario selecciona una
///   cuenta.
///
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
///
/// - Muestra las cuentas en un `Row` dentro de un
///   `SingleChildScrollView` horizontal.
/// - Cada cuenta se representa con un `AccountCard`.
/// - Al tocar una tarjeta, se invoca `onSelectAccount`
///   con la cuenta seleccionada.
/// - Resalta la tarjeta que coincide con `selectedAccount`.
///
/// ------------------------------------------------------------
/// Ejemplo:
/// ------------------------------------------------------------
///
/// ```dart
/// SelectAccount(
///   accounts: list,
///   selectedAccount: state.selected,
///   onSelectAccount: (acc) {},
/// )
/// ```
///
/// ------------------------------------------------------------

class SelectAccount extends StatelessWidget {
  const SelectAccount({
    super.key,
    required this.accounts,
    this.selectedAccount,
    required this.onSelectAccount,
  });

  final List<AccountModel> accounts;
  final AccountModel? selectedAccount;
  final void Function(AccountModel account) onSelectAccount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: accounts
            .map(
              (account) => AccountCard(
                account,
                isSelected: account == selectedAccount,
                select: () => onSelectAccount(account),
              ),
            )
            .toList(),
      ),
    );
  }
}
