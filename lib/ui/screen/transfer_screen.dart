import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/injection.dart';
import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';
import 'package:flutter_facade/ui/screen/success_screen.dart';
import 'package:flutter_facade/ui/utils/currency_utils.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';
import 'package:flutter_facade/ui/widgets/account_card.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  static const String routeName = 'transfer_screen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransferCubit(readIt()),
        ),
        //añadir bloc para consultar lista de cuentas del usuario
      ],
      child: const _TransferBody(),
    );
  }
}

class _TransferBody extends StatelessWidget {
  const _TransferBody();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.getTextTheme();
    final accounts = [
      AccountModel(
        number: "12341234",
        type: AccountType.ahorros,
        balance: 20000,
      ),
      AccountModel(
        number: "12341234",
        type: AccountType.corriente,
        balance: 30000,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TransferCubit, TransferState>(
          builder: (context, state) {
            final AccountModel? selectedAccount = state.selectedAccount;

            String strValue = state.value != null
                ? state.value?.getSimpleCurrencyFormat() ?? ' '
                : '';
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: accounts
                          .map(
                            (account) => AccountCard(
                              account,
                              isSelected: account == state.selectedAccount,
                              select: () {
                                context
                                    .read<TransferCubit>()
                                    .setSelectedAccount(account);
                              },
                            ),
                          )
                          .toList(),
                    ),
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
                        context.read<TransferCubit>().setValue(
                          double.tryParse(newValue) ?? 0,
                        );
                      },
                      validator: (newValue) {
                        final numValue = (double.tryParse(newValue ?? '') ?? 0);
                        if (numValue > selectedAccount!.balance) {
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Numero de cuenta a transferir",
                        labelStyle: textTheme.labelSmall,
                      ),
                      onChanged: (value) {
                        context.read<TransferCubit>().setAccountToSend(value);
                      },
                    ),
                    const SizedBox(height: 8),
                  ],

                  Align(
                    child: ElevatedButton(
                      onPressed: !state.canContinue
                          ? null
                          : () {
                              // TODO(Cristian): programar parametros para navegación correcta
                              Navigator.of(
                                context,
                              ).pushReplacementNamed(
                                SuccessScreen.routeName,
                              );
                            },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
