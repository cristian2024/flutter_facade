import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/models/user_model.dart';


/// ------------------------------------------------------------
/// AccountRepository
/// ------------------------------------------------------------
///
/// Contrato que define las operaciones relacionadas con
/// la obtención de cuentas de usuario.
abstract interface class AccountRepository{

  
///   Obtiene la lista de cuentas asociadas a un usuario.
/// ------------------------------------------------------------
/// Parámetros:
/// ------------------------------------------------------------
/// * [user]
///   Instancia de `UserModel` para la cual se desean obtener
///   las cuentas.
/// ------------------------------------------------------------
/// Retorno:
/// ------------------------------------------------------------
/// - `Future<List<AccountModel>>`
///   Lista de cuentas pertenecientes al usuario.
  Future<List<AccountModel>> getAccountsOfUser(UserModel user);
}