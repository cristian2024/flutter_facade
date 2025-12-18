import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/exceptions.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';
import 'package:flutter_facade/domain/usecases/account_usecase.dart';
import 'package:flutter_facade/ui/enums/state_enums.dart';

part 'accounts_state.dart';

/// ------------------------------------------------------------
/// AccountsCubit
/// ------------------------------------------------------------
///
/// Cubit responsable de gestionar el estado relacionado con
/// las cuentas de un usuario.
///
/// Se encarga de orquestar la obtención de las cuentas
/// asociadas a un `UserModel`, delegando la lógica de negocio
/// al `AccountUsecase` y exponiendo el resultado a la UI a
/// través de `AccountsState`.
///
/// ------------------------------------------------------------
/// Responsabilidad:
/// ------------------------------------------------------------
///
/// - Solicitar las cuentas de un usuario.
/// - Emitir estados de carga, éxito y error.
/// - Exponer la lista de cuentas listas para ser consumidas
///   por la capa de presentación.
///
/// ------------------------------------------------------------
/// Dependencias:
/// ------------------------------------------------------------
///
/// * [UserModel]
///   Usuario del cual se desean obtener las cuentas.
///
/// * [AccountUsecase]
///   Caso de uso encargado de ejecutar la lógica de negocio
///   para la obtención de cuentas.
///
/// ------------------------------------------------------------
/// Estados emitidos:
/// ------------------------------------------------------------
///
/// - `Status.loading`
///   Indica que las cuentas se están obteniendo.
///
/// - `Status.success`
///   Indica que las cuentas fueron obtenidas exitosamente y
///   se encuentran disponibles en el estado.
///
/// - `Status.error`
///   Indica que ocurrió un error durante la obtención de
///   las cuentas.
///
/// ------------------------------------------------------------
/// Manejo de errores:
/// ------------------------------------------------------------
///
/// - Captura excepciones del tipo `CustomException`.
/// - En caso de error, emite un estado con `Status.error`,
///   delegando a la UI la responsabilidad de reaccionar
///   (mostrar alertas, mensajes, etc.).
///
/// ------------------------------------------------------------
class AccountsCubit extends Cubit<AccountsState> {
  final UserModel user;
  final AccountUsecase _useCase;
  AccountsCubit(
    this.user, {
    required AccountUsecase useCase,
  }) : _useCase = useCase,
       super(AccountsState());


  /// Obtiene la lista de cuentas asociadas al usuario actual.
  Future<void> getAccountsOfUser() async {
  

    emit(state.copyWith(status: Status.loading));

    try {
      final list = await _useCase.getAccountsOfUser(user);

      emit(
        state.copyWith(
          status: Status.success,
          accounts: list,
        ),
      );
    } on CustomException {
      emit(
        state.copyWith(
          status: Status.error,
        ),
      );
    }
  }
}
