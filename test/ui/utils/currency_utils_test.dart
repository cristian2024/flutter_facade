import 'package:test/test.dart';
import 'package:flutter_facade/ui/utils/currency_utils.dart';

void main() {
  group(
    "currency_utils_test",
    () {
      test(
        'Formats without decimal points',
        () async {
          final double valueToFormat = 20000.05;

          final String valueFormatted = valueToFormat.getSimpleCurrencyFormat();

          expect(valueFormatted, isNot("\$20,000.05"));
          expect(valueFormatted, "\$20,000");
        },
      );
    },
  );
}
