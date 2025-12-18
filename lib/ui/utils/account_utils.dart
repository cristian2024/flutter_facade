import 'package:flutter_facade/domain/account_type.dart';

extension AccountTypeUtils on AccountType {
  String get titleValue {
    return switch (this) {
      AccountType.ahorros => "Cuenta de ahorros",
      AccountType.corriente => "Cuenta corriente",
      AccountType.otra => "Otro tipo de cuenta",
    };
  }
}
