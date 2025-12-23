import 'package:flutter_facade/application/transfer_facade.dart';
import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/services/analytics_service.dart';
import 'package:flutter_facade/domain/services/security_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/usecases/transfer_usecase.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockSecurityService extends Mock implements SecurityService {}

class MockTransferUsecase extends Mock implements TransferUsecase {}

void main() {
  late MockAnalyticsService analyticsService;
  late MockSecurityService securityService;
  late MockTransferUsecase transferUsecase;
  late TransferFacade facade;

  setUp(() {
    analyticsService = MockAnalyticsService();
    securityService = MockSecurityService();
    transferUsecase = MockTransferUsecase();

    facade = TransferFacade(
      analyticsService: analyticsService,
      securityService: securityService,
      transferUsecase: transferUsecase,
    );

    when(
      () => analyticsService.sendEvent(any()),
    ).thenAnswer((_) async {});
  });

  group('TransferFacade.transfer', () {
    test('ejecuta el flujo completo correctamente', () async {
      // Arrange
      final account = AccountModel(
        id: '1',
        type: AccountType.ahorros,
        balance: 1000,
      );

      when(
        () => securityService.getToken(),
      ).thenAnswer((_) async => 'secure-token');

      when(
        () => transferUsecase.transfer(
          any(),
          account: account,
          value: any(named: 'value'),
          toAccoutNumber: any(named: 'toAccoutNumber'),
        ),
      ).thenAnswer((_) async {});

      // Act
      await facade.transfer(
        account: account,
        value: 100,
        toAccoutNumber: '123456',
      );

      // Assert
      verify(() => securityService.getToken()).called(1);

      verify(() => analyticsService.sendEvent('transfer_event')).called(1);

      verify(
        () => transferUsecase.transfer(
          'secure-token',
          account: account,
          value: 100,
          toAccoutNumber: '123456',
        ),
      ).called(1);

      verifyNoMoreInteractions(analyticsService);
      verifyNoMoreInteractions(securityService);
      verifyNoMoreInteractions(transferUsecase);
    });

    test('si getToken falla, no se ejecuta el resto del flujo', () async {
      // Arrange
      when(
        () => securityService.getToken(),
      ).thenThrow(Exception('Token error'));
      final account = AccountModel(
        id: '1',
        type: AccountType.ahorros,
        balance: 100,
      );
      // Act
      await expectLater(
        () => facade.transfer(
          account: account,
          value: 50,
          toAccoutNumber: '123',
        ),
        throwsException,
      );

      // Assert
      verify(() => securityService.getToken()).called(1);

      verifyNever(() => analyticsService.sendEvent(any()));
      verifyNever(
        () => transferUsecase.transfer(
          any(),
          account: account,
          value: any(named: 'value'),
          toAccoutNumber: any(named: 'toAccoutNumber'),
        ),
      );
    });

    test('si el usecase falla, el error se propaga', () async {
      final account = AccountModel(
        id: '1',
        type: AccountType.ahorros,
        balance: 500,
      );
      // Arrange
      when(
        () => securityService.getToken(),
      ).thenAnswer((_) async => 'secure-token');

      when(
        () => transferUsecase.transfer(
          any(),
          account: account,
          value: any(named: 'value'),
          toAccoutNumber: any(named: 'toAccoutNumber'),
        ),
      ).thenThrow(Exception('Transfer error'));

      // Act
      await expectLater(
        () => facade.transfer(
          account: account,
          value: 100,
          toAccoutNumber: '456',
        ),
        throwsException,
      );

      // Assert
      verify(() => analyticsService.sendEvent('transfer_event')).called(1);
      verify(
        () => transferUsecase.transfer(
          'secure-token',
          account: account,
          value: any(named: 'value'),
          toAccoutNumber: any(named: 'toAccoutNumber'),
        ),
      ).called(1);
    });
  });
}
