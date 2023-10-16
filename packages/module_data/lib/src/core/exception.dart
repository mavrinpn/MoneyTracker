class ServerException implements Exception {}

class UserProfileException implements Exception {
  final String errorKey;

  const UserProfileException([
    this.errorKey = 'unknown_exception',
  ]);

  factory UserProfileException.fromCode(String code) {
    return UserProfileException(code);
  }
}

class AuthenticationException implements Exception {
  final String errorCode;

  const AuthenticationException([
    this.errorCode = 'unknown_exception',
  ]);

  factory AuthenticationException.fromCode(String code) {
    return AuthenticationException(code);
  }
}
