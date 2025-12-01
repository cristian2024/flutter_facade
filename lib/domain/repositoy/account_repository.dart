import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';

abstract interface class AccountRepository{
  Future<List<AccountModel>> getAccountsOfUser(UserModel user);
}