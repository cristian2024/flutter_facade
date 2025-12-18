import 'package:test/test.dart';
import 'package:flutter_facade/ui/enums/state_enums.dart';

void main() {
  group('Status enum getters', () {
    test('isLoading es true solo cuando el estado es loading', () {
      expect(Status.loading.isLoading, isTrue);

      expect(Status.ready.isLoading, isFalse);
      expect(Status.success.isLoading, isFalse);
      expect(Status.error.isLoading, isFalse);
    });

    test('hasBeenSuccessful es true solo cuando el estado es success', () {
      expect(Status.success.hasBeenSuccessful, isTrue);

      expect(Status.ready.hasBeenSuccessful, isFalse);
      expect(Status.loading.hasBeenSuccessful, isFalse);
      expect(Status.error.hasBeenSuccessful, isFalse);
    });

    test('hasError es true solo cuando el estado es error', () {
      expect(Status.error.hasError, isTrue);

      expect(Status.ready.hasError, isFalse);
      expect(Status.loading.hasError, isFalse);
      expect(Status.success.hasError, isFalse);
    });

    test('los flags del Status son mutuamente excluyentes', () {
      for (final status in Status.values) {
        final trueFlags = [
          status.isLoading,
          status.hasBeenSuccessful,
          status.hasError,
        ].where((v) => v).length;

        expect(trueFlags <= 1, isTrue);
      }
    });
  });
}
