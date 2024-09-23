import '../../presentation/home/data/cities.dart';
import '../../presentation/home/data/project_model.dart';

abstract class CitiesState {}

class CitiesInitial extends CitiesState {}

class CitiesLoading extends CitiesState {
  final int page;
  CitiesLoading({required this.page});
}

class CitiesLoaded extends CitiesState {
  final List<Cities> cites;
  final int page;
  final bool hasReachedMax;

  CitiesLoaded({
    required this.cites,
    required this.page,
    required this.hasReachedMax,
  });
}

class CitiesError extends CitiesState {
  final String message;

  CitiesError({required this.message});
}



abstract class CitiesAllState {}

class CitiesAllInitial extends CitiesAllState {}

class CitiesAllLoading extends CitiesAllState {
  final int page;

  CitiesAllLoading({required this.page});
}

class CitiesAllLoaded extends CitiesAllState {
  final List<Project> projects;
  final bool hasReachedMax;
  final int page;
  final int projectId;

  CitiesAllLoaded({
    required this.projects,
    required this.hasReachedMax,
    required this.page,
    required this.projectId,
  });
}

class CitiesAllError extends CitiesAllState {
  final String message;

  CitiesAllError({required this.message});
}
