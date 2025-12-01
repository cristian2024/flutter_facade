import 'dart:developer';

import 'package:flutter_facade/domain/services/analytics_service.dart';

class AnalyticsFakeService implements AnalyticsService {
  @override
  Future<void> sendEvent(
    String event, [
    Map<String, dynamic>? optionalContent,
  ]) async{
    log("Evento enviado");
    await  Future.delayed(Duration(seconds: 1));
  }
}
