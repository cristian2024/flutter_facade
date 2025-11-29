import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';
import 'package:flutter_facade/domain/usecases/account_usecase.dart';
import 'package:flutter_facade/ui/enums/state_enums.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final UserModel user;
  final AccountUsecase _useCase;
  AccountsCubit(
    this.user, {
    required AccountUsecase useCase,
  }) : _useCase = useCase,
       super(AccountsState());

  Future<void> getAccountsOfUser() async {
    //TODO(Cristian): validar errores

    emit(state.copyWith(status: Status.loading));

    final list = await _useCase.getAccountsOfUser(user);

    emit(
      state.copyWith(
        status: Status.success,
        accounts: list,
      ),
    );
  }
}
