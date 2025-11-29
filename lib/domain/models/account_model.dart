import 'package:equatable/equatable.dart';
import 'package:flutter_facade/domain/account_type.dart';

class AccountModel extends Equatable {
  final String id;
  final AccountType type;
  final double balance;

  const AccountModel({
    required this.id,
    required this.type,
    required this.balance,
  });

  @override
  List<Object?> get props => [id, type, balance];
}
