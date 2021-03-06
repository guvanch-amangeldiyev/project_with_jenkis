import 'package:domain/model/auth/authorization_exception.dart';

class LoginData {
  String loginInput = '';
  String passwordInput = '';
  AuthException? exception;

  LoginData(this.loginInput, this.passwordInput, this.exception);

  factory LoginData.init() => LoginData('', '', null);

  LoginData copy() => LoginData(loginInput, passwordInput, exception);
}
