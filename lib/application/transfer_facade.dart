import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/services/analytics_service.dart';
import 'package:flutter_facade/domain/services/security_service.dart';
import 'package:flutter_facade/domain/usecases/transfer_usecase.dart';

class TransferFacade {
  final AnalyticsService analyticsService;
  final SecurityService securityService;
  final TransferUsecase transferUsecase;

  TransferFacade({
    required this.analyticsService,
    required this.securityService,
    required this.transferUsecase,
  });

  Future<void> transfer({
    required AccountModel account,
    required double value,
    required String toAccoutNumber,
  }) async {
    final token = await securityService.getToken();
    analyticsService.sendEvent(_transferEventName);
    await transferUsecase.transfer(
      token,
      account: account,
      value: value,
      toAccoutNumber: toAccoutNumber,
    );
  }

  static const String _transferEventName = "transfer_event";
}
