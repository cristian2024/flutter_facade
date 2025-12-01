import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/application/transfer_facade.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/ui/enums/state_enums.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final TransferFacade _facade;

  TransferCubit(this._facade) : super(TransferState());

  Future<void> transfer() async {
    // state.isValid valida si las variables son nulas o no
    if (state.isValid) {
      emit(state.copyWith(status: Status.loading));

      try {
        await _facade.transfer(
          account: state.selectedAccount!,
          value: state.value!,
          toAccoutNumber: state.accountToSend!,
        );
        emit(state.copyWith(status: Status.success));
      } on CustomException catch (exception) {
        emit(
          state.copyWith(
            status: Status.error,
            exception: exception,
          ),
        );
      } catch (_) {
        emit(
          state.copyWith(
            status: Status.error,
            exception: ErrorTransferingException(),
          ),
        );
      }
    }
  }

  void setSelectedAccount(AccountModel account) {
    emit(state.copyWith(selectedAccount: account));
  }

  void setAccountToSend(String account) {
    emit(state.copyWith(accountToSend: account));
  }

  void setValue(double value) {
    emit(state.copyWith(value: value));
  }
}
