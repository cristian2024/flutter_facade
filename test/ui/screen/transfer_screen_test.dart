import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';
import 'package:flutter_facade/ui/enums/state_enums.dart';
import 'package:flutter_facade/ui/provider/accounts/accounts_cubit.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';
import 'package:flutter_facade/ui/screen/transfer_screen.dart';
import 'package:flutter_facade/ui/widgets/alert_exception.dart';
import 'package:flutter_facade/ui/widgets/transfer_body.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../configuration/base_app.dart';
import '../../configuration/finders/ui_finders.dart';
import '../../configuration/mocks/common_mocks.dart';
import '../../configuration/mocks/transfer_mocks.dart';

void main() {
  group("Transfer screen tests", () {
    testWidgets("happyPath", (tester) async {
      bool successCalled = false;

      // -------------------------
      // Render
      // -------------------------
      await tester.pumpWidget(
        BaseApp(
          child: TransferScreen(
            onTransferSuccess: () {
              successCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // -------------------------
      // Seleccionar cuenta
      // -------------------------
      await tester.tap(find.text('Principal'));
      await tester.pump();

      // -------------------------
      // Ingresar valor
      // -------------------------
      await tester.enterText(
        setTransferAmountFr,
        '100',
      );
      await tester.pump();

      // -------------------------
      // Ingresar cuenta destino
      // -------------------------
      await tester.enterText(
        setTransferToAccountFr,
        '123456',
      );
      await tester.pump();

      expect(
        tester.widget<ElevatedButton>(sendTransferBtn).onPressed,
        isNotNull,
      );

      await tester.tap(sendTransferBtn);
      await tester.pumpAndSettle();

      // -------------------------
      // Assert
      // -------------------------
      expect(successCalled, isTrue);
    });
  });
}
