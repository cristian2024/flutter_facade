import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';
import 'package:flutter_facade/domain/repositoy/account_repository.dart';

class AccountUsecase {
  final AccountRepository _accountRepository;

  AccountUsecase(this._accountRepository);

  Future<List<AccountModel>> getAccountsOfUser(UserModel user) =>
      _accountRepository.getAccountsOfUser(user);
}
