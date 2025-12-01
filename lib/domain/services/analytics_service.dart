abstract interface class AnalyticsService {
  Future<void> sendEvent(
    String event, [
    Map<String, dynamic>? optionalContent,
  ]);
}
