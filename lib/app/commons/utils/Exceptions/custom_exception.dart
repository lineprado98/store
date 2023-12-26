abstract class CustomException {}

//storage
class StorageUnknown implements CustomException {}

class StorageObjectNotFound implements CustomException {}

//database
class DatabaseFailure implements CustomException {}

class ObjectNotFound implements CustomException {}

class ProjectNotFound implements CustomException {}

class Unauthenticated implements CustomException {}

//Signin
class InvalidUserCredentials implements CustomException {}

class UnknowUserCredential implements CustomException {}

//User create
class FailedCreateAccount implements CustomException {}

class UserAlreadyExists implements CustomException {}

class InternalError implements CustomException {}

class EmailAlreadyExists implements CustomException {}

class UserNotFound implements CustomException {}

class TooManyRequests implements CustomException {}

class InvalidPassword implements CustomException {}

class EmailAlreadyInUse implements CustomException {}
