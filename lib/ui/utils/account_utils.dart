import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';

extension AccountUtils on AccountModel {}

extension AccountTypeUtils on AccountType {
  String get titleValue {
    return switch (this) {
      AccountType.ahorros => "Cuenta de ahorros",
      AccountType.corriente => "Cuenta corriente",
      AccountType.otra => "Otro tipo de cuenta",
    };
  }
}
