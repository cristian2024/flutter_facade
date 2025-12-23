import 'package:flutter/material.dart';
import 'package:flutter_facade/ui/screen/transfer_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../configuration/base_app.dart';
import '../../configuration/finders/ui_finders.dart';

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
