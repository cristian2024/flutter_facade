import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';
import 'package:flutter_facade/domain/repositoy/account_repository.dart';
import 'package:flutter_facade/infrastructure/fakes/account_fakes.dart';

class AccountFakeRepository implements AccountRepository {
  @override
  Future<List<AccountModel>> getAccountsOfUser(UserModel user) async {
    await Future.delayed(Duration(seconds: 1));
    return fakeAccounts;
  }
}
