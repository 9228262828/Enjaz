
abstract class SettingState {}

class SettingInitial extends SettingState {}

class SettingLoaded extends SettingState {
  final String userName;

  SettingLoaded({required this.userName});
}

class SettingUnauthenticated extends SettingState {}

class SettingError extends SettingState {
  final String message;

  SettingError({required this.message});
}

class SettingLogoutSuccess extends SettingState {}

class SettingAccountDeleted extends SettingState {}

class SettingLogoutError extends SettingState {
  final String message;

  SettingLogoutError({required this.message});
}

class SettingAccountDeletionError extends SettingState {
  final String message;

  SettingAccountDeletionError({required this.message});
}
