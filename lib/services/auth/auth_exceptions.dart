

// *login exceptions
class UserNotFoundAuthException implements Exception{}
class WrongPasswordAuthException implements Exception{}


// *register exceptions
class WeakPasswordAuthException implements Exception{}
class EmealAlreadyInUseAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}



// *generic exceptions
class GenericAuthException implements Exception{}
class UserNotLogdedInAuthException implements Exception{}
