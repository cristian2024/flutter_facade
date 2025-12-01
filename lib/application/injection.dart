import 'package:flutter_facade/application/transfer_facade.dart';
import 'package:flutter_facade/domain/repositoy/account_repository.dart';
import 'package:flutter_facade/domain/repositoy/transfer_repository.dart';
import 'package:flutter_facade/domain/services/analytics_service.dart';
import 'package:flutter_facade/domain/services/security_service.dart';
import 'package:flutter_facade/domain/usecases/account_usecase.dart';
import 'package:flutter_facade/domain/usecases/transfer_usecase.dart';
import 'package:flutter_facade/infrastructure/repository/account_fake_repository.dart';
import 'package:flutter_facade/infrastructure/repository/transfer_fake_repository.dart';
import 'package:flutter_facade/infrastructure/services/analytics_fake_service.dart';
import 'package:flutter_facade/infrastructure/services/security_fake_service.dart';
import 'package:get_it/get_it.dart';

final _instance = GetIt.asNewInstance();

void inject() {
  //repositorios
  final TransferRepository transferRepository = TransferFakeRepository();
  final AccountRepository accountRepository = AccountFakeRepository();
  _instance.registerSingleton(transferRepository);
  _instance.registerSingleton(accountRepository);

  //casos de uso
  final TransferUsecase transferUsecase = TransferUsecase(
    repository: transferRepository,
  );
  final AccountUsecase accountUsecase = AccountUsecase(accountRepository);
  _instance.registerSingleton(transferUsecase);
  _instance.registerSingleton(accountUsecase);

  //servicios
  final AnalyticsService analyticsService = AnalyticsFakeService();
  final SecurityService securityService = SecurityFakeService();
  _instance.registerSingleton(analyticsService);
  _instance.registerSingleton(securityService);

  //Facade
  final TransferFacade transferFacade = TransferFacade(
    analyticsService: analyticsService,
    securityService: securityService,
    transferUsecase: transferUsecase,
  );
  _instance.registerSingleton(transferFacade);
}

T readIt<T extends Object>() {
  //TODO(Cristian): validar cuando no se ha inyectado el objeto T
  return _instance.get();
}
