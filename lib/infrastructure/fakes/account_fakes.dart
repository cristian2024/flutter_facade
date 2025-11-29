    import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';

final List<AccountModel> fakeAccounts = [
      AccountModel(
        number: "12341234",
        type: AccountType.ahorros,
        balance: 20000,
      ),
      AccountModel(
        number: "12341234",
        type: AccountType.corriente,
        balance: 30000,
      ),
    ];