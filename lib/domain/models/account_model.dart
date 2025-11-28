import 'package:equatable/equatable.dart';
import 'package:flutter_facade/domain/account_type.dart';

class AccountModel extends Equatable {
  final String number;
  final AccountType type;
  final double balance;

  const AccountModel({
    required this.number,
    required this.type,
    required this.balance,
  });

  @override
  List<Object?> get props => [number, type, balance];
}
