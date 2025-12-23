import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/ui/enums/state_enums.dart';
import 'package:flutter_facade/ui/provider/accounts/accounts_cubit.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';
import 'package:flutter_facade/ui/widgets/transfer_body.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../configuration/base_app.dart';
import '../../configuration/finders/ui_finders.dart';
import '../../configuration/mocks/transfer_mocks.dart';

void main() {
  group(
    "Transfer screen tests",
    () {
      group("Success validations", () {
        late AccountsCubit accountsCubit;
        late TransferCubit transferCubit;

        setUp(
          () {
            accountsCubit = MockAccountsCubit();
            transferCubit = MockTransferCubit();

            final loadingAccountState = AccountsState(
              status: Status.loading,
            );

            final successAccountState = AccountsState(
              status: Status.success,
              accounts: fakeAccounts,
            );



            //transfer states
            final initialState = TransferState(
              status: Status.ready,
            );

            final loadingState = TransferState(
              status: Status.loading,
            );

            final successState = TransferState(
              status: Status.success,
            );


            when(() => accountsCubit.state).thenReturn(loadingAccountState);

            when(() => transferCubit.state).thenReturn(initialState);

            whenListen(
              transferCubit,
              Stream.fromIterable([
                loadingState,
                successState,
              ]),
            );

            whenListen(
              accountsCubit,
              Stream.fromIterable([
                loadingAccountState,
                successAccountState,
              ]),
            );
          },
        );
        testWidgets(
          "Should not show options if account is not selected",
          (tester) async {
            await tester.pumpWidget(
              BaseApp(
                providers: [
                  BlocProvider<AccountsCubit>(
                    create: (context) => accountsCubit,
                    lazy: false,
                  ),
                  BlocProvider<TransferCubit>(
                    create: (context) => transferCubit,
                  ),
                ],
                child: Scaffold(
                  body: Builder(
                    builder: (context) {
                      return TransferBody(
                        onTransferSuccess: () {},
                      );
                    },
                  ),
                ),
              ),
            );
            await tester.pumpAndSettle();

            expect(selectAccount, findsOneWidget);
            expect(setValueToTransferFr, findsNothing);
            expect(setAccountNumberToTransferFr, findsNothing);

            //botón deshabilitado
            final button = tester.widget<ElevatedButton>(
              sendTransferBtn,
            );
            expect(button.onPressed, null);
          },
        );
        testWidgets(
          'ejecuta onTransferSuccess cuando el status es success',
          (tester) async {
            // Arrange
            final transferCubit = MockTransferCubit();
            final accountsCubit = MockAccountsCubit();

            bool successCalled = false;

            final initialState = const TransferState(
              status: Status.ready,
            );

            final successState = initialState.copyWith(
              status: Status.success,
            );

            when(() => transferCubit.state).thenReturn(initialState);
            whenListen(
              transferCubit,
              Stream.fromIterable([initialState, successState]),
            );

            when(() => accountsCubit.state).thenReturn(
              AccountsState(
                status: Status.ready,
                accounts: const [],
              ),
            );

            // Act
            await tester.pumpWidget(
              MultiBlocProvider(
                providers: [
                  BlocProvider<TransferCubit>.value(value: transferCubit),
                  BlocProvider<AccountsCubit>.value(value: accountsCubit),
                ],
                child: MaterialApp(
                  home: Scaffold(
                    body: TransferBody(
                      onTransferSuccess: () {
                        successCalled = true;
                      },
                    ),
                  ),
                ),
              ),
            );

            await tester.pump(); // procesa el stream

            // Assert
            expect(successCalled, isTrue);
          },
        );
      });

      group("Error validatiosn", () {
        testWidgets(
          'Shows alert error when exception is thrown',
          (tester) async {
            // Arrange
            final transferCubit = MockTransferCubit();
            final accountsCubit = MockAccountsCubit();

            bool successCalled = false;

            final initialState = const TransferState(
              status: Status.ready,
            );

            final errorState = initialState.copyWith(
              status: Status.error,
              exception: ErrorTransferingException(),
            );

            when(() => transferCubit.state).thenReturn(initialState);
            whenListen(
              transferCubit,
              Stream.fromIterable([initialState, errorState]),
            );

            when(() => accountsCubit.state).thenReturn(
              AccountsState(
                status: Status.ready,
                accounts: const [],
              ),
            );

            // Act
            await tester.pumpWidget(
              MultiBlocProvider(
                providers: [
                  BlocProvider<TransferCubit>.value(value: transferCubit),
                  BlocProvider<AccountsCubit>.value(value: accountsCubit),
                ],
                child: MaterialApp(
                  home: Scaffold(
                    body: TransferBody(
                      onTransferSuccess: () {
                        successCalled = true;
                      },
                    ),
                  ),
                ),
              ),
            );

            // Procesa el stream y muestra el dialog
            await tester.pump();
            await tester.pump(const Duration(milliseconds: 100));

            // Assert
            expect(alertExceptionFr, findsOneWidget);
            expect(successCalled, isFalse);

            await tester.tap(alertExceptionButtonFr);
            await tester.pumpAndSettle();
            await tester.pump(const Duration(milliseconds: 100));

            expect(alertExceptionFr, findsNothing);
            
          },
        );
      });
    },
  );
}
