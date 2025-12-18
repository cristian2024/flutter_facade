import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facade/ui/screen/success_screen.dart';

import '../../configuration/base_app.dart';

void main() {
  group('SuccessScreen', () {
    testWidgets(
      'muestra el mensaje de transacción exitosa',
      (tester) async {
        await tester.pumpWidget(
          BaseApp(
            shouldInject: true,

            child: SuccessScreen(
              onPopScreen: () {},
            ),
          ),
        );

        expect(find.text('Transacción exitosa'), findsOneWidget);
      },
    );

    testWidgets(
      'muestra el icono de éxito dentro de un Hero',
      (tester) async {
        await tester.pumpWidget(
          BaseApp(
            shouldInject: true,
            child: SuccessScreen(
              onPopScreen: () {},
            ),
          ),
        );

        expect(find.byType(Hero), findsOneWidget);
        expect(
          find.byIcon(Icons.check_circle_outline_outlined),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'ejecuta onPopScreen al presionar el botón',
      (tester) async {
        bool wasCalled = false;

        await tester.pumpWidget(
          BaseApp(
            shouldInject: true,
            child: SuccessScreen(
              onPopScreen: () {
                wasCalled = true;
              },
            ),
          ),
        );

        await tester.tap(find.text('Presiona para volver'));
        await tester.pump();

        expect(wasCalled, isTrue);
      },
    );

    testWidgets(
      'ejecuta onPopScreen al presionar el botón de back del AppBar',
      (tester) async {
        bool wasCalled = false;

        await tester.pumpWidget(
          BaseApp(
            shouldInject: true,
            child: SuccessScreen(
              onPopScreen: () {
                wasCalled = true;
              },
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.arrow_back));
        await tester.pump();

        expect(wasCalled, isTrue);
      },
    );
  });
}
