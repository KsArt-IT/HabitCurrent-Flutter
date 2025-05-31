sealed class AppError implements Exception {
  final String message;

  AppError(this.message);
}

final class UserInitialError extends AppError {
  UserInitialError(super.message);
}

final class UserLoadingError extends AppError {
  UserLoadingError(super.message);
}

final class UserSavingError extends AppError {
  UserSavingError(super.message);
}

final class DatabaseError extends AppError {
  DatabaseError(super.message);
}

final class DatabaseCreatingError extends AppError {
  DatabaseCreatingError(super.message);
}

final class DatabaseLoadingError extends AppError {
  DatabaseLoadingError(super.message);
}

final class DatabaseSavingError extends AppError {
  DatabaseSavingError(super.message);
}

final class DatabaseDeletingError extends AppError {
  DatabaseDeletingError(super.message);
}

final class UnknownError extends AppError {
  UnknownError(super.message);
}