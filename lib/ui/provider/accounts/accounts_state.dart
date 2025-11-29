part of 'accounts_cubit.dart';

class AccountsState extends Equatable {
  const AccountsState({
    this.status = Status.ready,
    this.accounts,
  });

  final Status status;
  final List<AccountModel>? accounts;

  @override
  List<Object?> get props => [status, accounts,];
  AccountsState copyWith({
    Status? status,
    List<AccountModel>? accounts,
  }) {
    return AccountsState(
      status: status ?? this.status,
      accounts: accounts ?? this.accounts,
    );
  }
}
