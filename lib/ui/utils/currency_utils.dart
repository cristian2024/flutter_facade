import 'package:intl/intl.dart';

final _formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

extension CurrencyUtils on double {
  String getSimpleCurrencyFormat() {
    return _formatCurrency.format(this);
  }
}
