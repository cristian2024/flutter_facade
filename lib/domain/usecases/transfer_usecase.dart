import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/repositoy/transfer_repository.dart';

class TransferUsecase {
  final TransferRepository _repository;

  TransferUsecase({
    required TransferRepository repository,
  }) : _repository = repository;

  Future<void> transfer(
    String token, {
    required AccountModel account,
    required double value,
    required String toAccoutNumber,
  }) => _repository.transfer(
    token,
    account: account,
    value: value,
    toAccoutNumber: toAccoutNumber,
  );
}
