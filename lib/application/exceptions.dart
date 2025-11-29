class CustomException implements Exception {
  final String message;

  CustomException(this.message);
}

class ErrorTransferingException extends CustomException {
  ErrorTransferingException()
    : super("Error desconocido ejecutando la transacción");
}

class AccountBlockedException extends CustomException {
  AccountBlockedException()
    : super("La cuenta que seleccionaste se encuentra bloqueada");
}

class AccountToSendDoesNotExistException extends CustomException {
  AccountToSendDoesNotExistException()
    : super("La cuenta a enviar no existe");
}


