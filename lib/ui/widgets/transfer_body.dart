import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/ui/provider/accounts/accounts_cubit.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';
import 'package:flutter_facade/ui/screen/success_screen.dart';
import 'package:flutter_facade/ui/utils/currency_utils.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';
import 'package:flutter_facade/ui/widgets/alert_exception.dart';
import 'package:flutter_facade/ui/widgets/select_account.dart';

/// ------------------------------------------------------------
/// TransferBody
/// ------------------------------------------------------------
///
/// Widget que construye el cuerpo principal del flujo de
/// transferencia de dinero.
///
/// Se encarga de renderizar el formulario completo de
/// transferencia, consumiendo el estado de `TransferCubit`
/// y `AccountsCubit`.
///
/// No contiene lógica de negocio; su responsabilidad es
/// exclusivamente de presentación y coordinación de eventos
/// de UI.
///
/// ------------------------------------------------------------
/// Dependencias:
/// ------------------------------------------------------------
///
/// * [TransferCubit]
///   Maneja el estado de la transferencia (cuenta seleccionada,
///   valor, cuenta destino, estado del proceso y errores).
///
/// * [AccountsCubit]
///   Provee la lista de cuentas disponibles del usuario.
///
/// ------------------------------------------------------------
/// Secciones de la UI:
/// ------------------------------------------------------------
///
/// 1. Título del flujo de transferencia.
/// 2. Selector de cuenta origen.
/// 3. Formulario de transferencia (condicional).
/// 4. Botón de acción principal.
/// 5. Listener para estados de éxito o error.
///
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
///
/// - Muestra un indicador de carga mientras se obtienen las
///   cuentas del usuario.
/// - Permite seleccionar una cuenta origen.
/// - Habilita el formulario únicamente cuando existe una
///   cuenta seleccionada.
/// - Valida que el valor a transferir no supere el saldo
///   disponible.
/// - Deshabilita el botón de transferencia cuando el estado
///   no permite continuar.
/// - Escucha cambios en el estado de la transferencia para:
///   * Mostrar un alert en caso de error.
///   * Navegar a la pantalla de éxito en caso de completar
///     la transferencia.
///
/// ------------------------------------------------------------
/// Navegación:
/// ------------------------------------------------------------
///
/// - En estado exitoso, reemplaza la ruta actual por
///   [SuccessScreen].
///
/// ------------------------------------------------------------
class TransferBody extends StatelessWidget {
  const TransferBody({
    super.key,
    required this.onTransferSuccess,
  });

  final VoidCallback onTransferSuccess;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.getTextTheme();

    final accountsCubit = context.watch<AccountsCubit>();
    final accountsState = accountsCubit.state;
  
    final transferCubit = context.watch<TransferCubit>();
    final transferState = transferCubit.state;

    final AccountModel? selectedAccount = transferState.selectedAccount;

    String strValue = transferState.value != null
        ? transferState.value?.getSimpleCurrencyFormat() ?? ' '
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Transfiere el dinero",
          style: textTheme.titleLarge,
        ),

        const SizedBox(height: 12),
        Text(
          "Selecciona una de tus cuentas",
          style: textTheme.titleMedium?.copyWith(
            color: context.getThemeData().primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (accountsState.status.isLoading)
          Center(child: CircularProgressIndicator())
        else
          SelectAccount(
            key: Key('transfer-screen_select-account'),
            accounts: accountsState.accounts ?? [],
            onSelectAccount: (account) =>
                transferCubit.setSelectedAccount(account),
            selectedAccount: transferState.selectedAccount,
          ),
        if (selectedAccount != null) ...[
          const SizedBox(height: 12),
          Text(
            "Selecciona el valor a transferir",
            style: textTheme.titleMedium?.copyWith(
              color: context.getThemeData().primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "tienes disponible: ${selectedAccount.balance.getSimpleCurrencyFormat()}",
            style: textTheme.labelSmall,
          ),
          TextFormField(
            key: const Key('transfer-screen_set-transfer-amount_tff'),
            decoration: InputDecoration(
              labelText: "Cuanto quieres transferir?: $strValue",
              labelStyle: textTheme.labelSmall,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 20,

            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              transferCubit.setValue(
                double.tryParse(newValue) ?? 0,
              );
            },
            validator: (newValue) {
              final numValue = (double.tryParse(newValue ?? '') ?? 0);
              if (numValue > selectedAccount.balance) {
                return "No tienes saldo suficiente";
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Text(
            "Digita el numero de cuenta a transferir",
            style: textTheme.titleMedium?.copyWith(
              color: context.getThemeData().primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            key: const Key('transfer-screen_set-transfer-to-account_tff'),
            decoration: InputDecoration(
              labelText: "Numero de cuenta a transferir",
              labelStyle: textTheme.labelSmall,
            ),
            onChanged: (value) {
              transferCubit.setAccountToSend(value);
            },
          ),
          const SizedBox(height: 8),
        ],

        Align(
          child: BlocListener<TransferCubit, TransferState>(
            listenWhen: (previous, current) {
              return (previous != current && current.status.hasBeenSuccessful) ||
                  current.status.hasError;
            },
            listener: (context, state) {
              if (state.status.hasError) {
                AlertException.showAlert(
                  context,
                  exception: state.exception ?? ErrorTransferingException(),
                );
                return;
              }

              onTransferSuccess();
            },
            child: ElevatedButton(
              key: Key('transfer-screen_transfer-button'),
              onPressed: !transferState.canContinue
                  ? null
                  : () {
                      transferCubit.transfer();
                    },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (transferState.status.isLoading)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  else ...[
                    Text(
                      "Transferir",
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    Hero(
                      tag: 'succes_animation',
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
