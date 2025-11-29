import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/repositoy/transfer_repository.dart';

class TransferFakeRepository implements TransferRepository {
  @override
  Future<void> transfer(
    String token, {
    required AccountModel account,
    required double value,
    required String toAccoutId,
  }) async {
    await Future.delayed(Duration(seconds: 2));

    if (account.id == '*errorTransfiriendo') {
      throw ErrorTransferingException();
    }
    if(account.id == '*noExiste'){
      throw AccountBlockedException();
    }
    if (toAccoutId == 'noexiste') {
      throw AccountToSendDoesNotExistException();
    }
    if (value == 15000) {
      throw IncorrectBalance();
    }
    
  }
}
