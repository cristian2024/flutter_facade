import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_facade/application/transfer_facade.dart';
import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/repositoy/transfer_repository.dart';
import 'package:flutter_facade/domain/services/analytics_service.dart';
import 'package:flutter_facade/domain/services/security_service.dart';
import 'package:flutter_facade/domain/usecases/transfer_usecase.dart';
import 'package:flutter_facade/ui/enums/state_enums.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../configuration/mocks/transfer_mocks.dart';

void main() {
  group('TransferCubit test', () {
    late final TransferRepository transferRepository;
    late final SecurityService securityService;
    late final AnalyticsService analyticsService;
    late TransferCubit transferCubit;
    late AccountModel account;

    setUp(
      () {
        transferCubit = TransferCubit(
          TransferFacade(
            analyticsService: analyticsService,
            securityService: securityService,
            transferUsecase: TransferUsecase(repository: transferRepository),
          ),
        );
      },
    );
    setUpAll(
      () {
        transferRepository = TransferMockRepository();
        securityService = SecurityMockService();
        analyticsService = AnalyticsMockService();

        account = AccountModel(
          id: "11234",
          balance: 30000,
          type: AccountType.ahorros,
        );

        when(
          () => transferRepository.transfer(
            any(),
            account: account,
            value: any(named: "value"),
            toAccoutId: any(named: "toAccoutId"),
          ),
        ).thenAnswer((_) async {});
        when(
          () => securityService.getToken(),
        ).thenAnswer(
          (_) async => "1234134",
        );
        when(
          () => analyticsService.sendEvent(any()),
        ).thenAnswer((invocation) async {});
      },
    );

    blocTest<TransferCubit, TransferState>(
      'Transfer process success',
      build: () {
        transferCubit.setAccountToSend("asdf");
        transferCubit.setSelectedAccount(account);
        transferCubit.setValue(20000);
        return transferCubit;
      },
      act: (cubit) => cubit.transfer(),
      expect: () => [
        isA<TransferState>().having(
          (state) => state.status,
          "loading state",
          Status.loading,
        ),
        isA<TransferState>().having(
          (state) => state.status,
          "Succes state",
          Status.success,
        ),
      ],
    );
    blocTest<TransferCubit, TransferState>(
      'Not valid data',
      build: () {
        transferCubit.setAccountToSend("asdf");
        transferCubit.setSelectedAccount(account);
        // no se configura uno de los parametros
        // transferCubit.setValue(20000);
        return transferCubit;
      },
      act: (cubit) => cubit.transfer(),
      expect: () => [],
    );
  });
}
