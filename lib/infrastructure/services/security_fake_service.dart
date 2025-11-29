import 'package:flutter_facade/domain/services/security_service.dart';

class SecurityFakeService implements SecurityService {
  @override
  Future<String> getToken() async {
    return 'nuevo_token';
  }
}
