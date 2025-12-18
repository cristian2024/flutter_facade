import 'package:flutter_facade/domain/models/account_model.dart';

/// ------------------------------------------------------------
/// TransferRepository
/// ------------------------------------------------------------
///
/// Contrato que define las operaciones necesarias para
/// ejecutar una transferencia de dinero.
abstract interface class TransferRepository {

///   Ejecuta una transferencia desde una cuenta origen
///   hacia una cuenta destino.
/// ------------------------------------------------------------
/// Parámetros:
/// ------------------------------------------------------------
/// * [token]
///   Token de autenticación requerido para autorizar
///   la operación.
///
/// * [account]
///   Cuenta origen desde la cual se realizará la
///   transferencia.
///
/// * [value]
///   Monto que será transferido.
///
/// * [toAccoutId]
///   Identificador de la cuenta destino.
/// ------------------------------------------------------------
/// Retorno:
/// ------------------------------------------------------------
/// - `Future<void>`
///   Completa la operación sin retornar un valor.
/// ------------------------------------------------------------
  Future<void> transfer(
    String token, {
    required AccountModel account,
    required double value,
    required String toAccoutId,
  });
}