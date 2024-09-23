import '../../presentation/home/data/developer_model.dart';

abstract class DeveloperState {}

class DeveloperInitial extends DeveloperState {}

class DeveloperLoading extends DeveloperState {
  final int page;
  DeveloperLoading({required this.page});
}

class DeveloperLoaded extends DeveloperState {
  final List<Developer> developers;
  final int page;
  final bool hasReachedMax;

  DeveloperLoaded({
    required this.developers,
    required this.page,
    required this.hasReachedMax,
  });
}

class DeveloperError extends DeveloperState {
  final String message;

  DeveloperError({required this.message});
}

abstract class DevelopersFeaturedState {}

class DevelopersFeaturedInitial extends DevelopersFeaturedState {}

class DevelopersFeaturedLoading extends DevelopersFeaturedState {
  final int page;
  DevelopersFeaturedLoading({required this.page});
}

class DevelopersFeaturedLoaded extends DevelopersFeaturedState {
  final List<Developer> developers;
  final int page;
  final bool hasReachedMax;

  DevelopersFeaturedLoaded({
    required this.developers,
    required this.page,
    required this.hasReachedMax,
  });
}

class DevelopersFeaturedError extends DevelopersFeaturedState {
  final String message;

  DevelopersFeaturedError({required this.message});
}
