import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/application/injection.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';
import 'package:flutter_facade/ui/provider/accounts/accounts_cubit.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';
import 'package:flutter_facade/ui/screen/success_screen.dart';
import 'package:flutter_facade/ui/utils/currency_utils.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';
import 'package:flutter_facade/ui/widgets/account_card.dart';
import 'package:flutter_facade/ui/widgets/alert_exception.dart';

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
        BlocProvider(
          create: (context) => AccountsCubit(
            UserModel(name: 'Pragma worker', id: '12341234'),
            useCase: readIt(),
          )..getAccountsOfUser(),
          lazy: false,
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: const _TransferBody(),
          ),
        ),
      ),
    );
  }
}

class _TransferBody extends StatelessWidget {
  const _TransferBody();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.getTextTheme();

    final transferCubit = context.watch<TransferCubit>();
    final transferState = transferCubit.state;

    final accountsCubit = context.watch<AccountsCubit>();
    final accountsState = accountsCubit.state;

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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: (accountsState.accounts ?? [])
                  .map(
                    (account) => AccountCard(
                      account,
                      isSelected: account == transferState.selectedAccount,
                      select: () {
                        transferCubit.setSelectedAccount(
                          account,
                        );
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
          TextField(
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
              return (previous != current && current.status.hasBeenSuccesful) ||
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

              Navigator.of(
                context,
              ).pushReplacementNamed(
                SuccessScreen.routeName,
              );
            },
            child: ElevatedButton(
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
