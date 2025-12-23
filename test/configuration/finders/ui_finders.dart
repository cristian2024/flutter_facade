import 'package:flutter/material.dart';
import 'package:flutter_facade/ui/widgets/account_card.dart';
import 'package:flutter_facade/ui/widgets/alert_exception.dart';
import 'package:flutter_test/flutter_test.dart';

final selectAccount = find.byKey(Key('transfer-screen_select-account'));
final sendTransferBtn = find.byKey(Key('transfer-screen_transfer-button'));
final accountCardFr = find.byType(AccountCard);
final setTransferAmountFr = find.byKey(Key('transfer-screen_set-transfer-amount_tff'));
final setTransferToAccountFr = find.byKey(Key('transfer-screen_set-transfer-to-account_tff'));

final setValueToTransferFr = find.descendant(
  of: find.byType(Text),
  matching: find.text('Selecciona el valor a transferir'),
);
final setAccountNumberToTransferFr = find.descendant(
  of: find.byType(Text),
  matching: find.text('Digita el numero de cuenta a transferir'),
);

final alertExceptionFr = find.byType(AlertException);
final alertExceptionButtonFr = find.descendant(
  of: alertExceptionFr,
  matching: find.byKey(
    Key('alert-error_close-button'),
  ),
);
