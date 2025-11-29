import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/ui/screen/success_screen.dart';
import 'package:flutter_facade/ui/utils/currency_utils.dart';
import 'package:flutter_facade/ui/utils/theme_extension.dart';
import 'package:flutter_facade/ui/widgets/account_card.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  static const String routeName = 'transfer_screen';

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  AccountModel? selectedAccount;
  double? value;

  // final ValueNotifier<AccountModel?> accountModifier = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    // TODO(Cristian)): obtener info del manejador de estado
    double availableValue = 20000;

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

    String strValue = value != null
        ? value?.getSimpleCurrencyFormat() ?? ' '
        : '';
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                          isSelected: selectedAccount == account,
                          select: () {
                            // TODO(Cristian): Mejorar manejo de estado
                            selectedAccount = account;
                            setState(() {});
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
                  "tienes disponible: ${selectedAccount?.balance.getSimpleCurrencyFormat()}",
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
                    value = double.tryParse(newValue) ?? 0;
                    setState(() {});
                  },
                  validator: (newValue) {
                    final numValue = (double.tryParse(newValue ?? '') ?? 0);
                    if (numValue > selectedAccount!.balance) {
                      return "No tienes saldo suficiente";
                    }
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
                ),
                const SizedBox(height: 8),
              ],

              Align(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO(Cristian): programar parametros para navegación correcta
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(SuccessScreen.routeName);
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
        ),
      ),
    );
  }
}
