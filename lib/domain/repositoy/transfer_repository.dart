import 'package:flutter_facade/domain/models/account_model.dart';

abstract interface class TransferRepository {
  Future<void> transfer(
    String token, {
    required AccountModel account,
    required double value,
    required String toAccoutNumber,
  }) async {
    //TODO(Cristian): validar algun tipo de flujo
  }
}
