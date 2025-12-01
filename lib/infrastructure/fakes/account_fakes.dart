import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';

final List<AccountModel> fakeAccounts = [
  AccountModel(
    id: "12341234",
    type: AccountType.ahorros,
    balance: 20000,
  ),
  AccountModel(
    id: "12341234",
    type: AccountType.ahorros,
    balance: 100000,
  ),
  AccountModel(
    id: "*errorTransfiriendo",
    type: AccountType.corriente,
    balance: 30000,
  ),
    AccountModel(
    id: "*noExiste",
    type: AccountType.corriente,
    balance: 30000,
  ),
];
