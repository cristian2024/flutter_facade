part of 'transfer_cubit.dart';

class TransferState extends Equatable {
  final AccountModel? selectedAccount;
  final String? accountToSend;
  final double? value;
  final Status status;

  const TransferState({
    this.selectedAccount,
    this.accountToSend,
    this.value,
    this.status = Status.ready,
  });

  TransferState copyWith({
    AccountModel? selectedAccount,
    String? accountToSend,
    double? value,
    Status? status,
  }) {
    Status newStatus = status ?? this.status;
    if (this.status == Status.error) {
      newStatus = status ?? Status.ready;
    }
    return TransferState(
      selectedAccount: selectedAccount ?? this.selectedAccount,
      accountToSend: accountToSend ?? this.accountToSend,
      value: value ?? this.value,
      status: newStatus,
    );
  }

  bool get isValid {
    return selectedAccount != null &&
        accountToSend != null &&
        value != null &&
        value! <= selectedAccount!.balance;
  }

  bool get canContinue {
    return isValid && ![Status.error, Status.loading].contains(status);
  }

  @override
  List<Object?> get props => [
    selectedAccount,
    accountToSend,
    value,
    status,
  ];
}
