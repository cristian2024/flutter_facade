import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/repositoy/transfer_repository.dart';

class TransferFakeRepository implements TransferRepository {
  @override
  Future<void> transfer(
    String token, {
    required AccountModel account,
    required double value,
    required String toAccoutNumber,
  }) async {
    // TODO(Cristian): implementar casos controlados de error
    await Future.delayed(Duration(seconds: 2));
  }
}
