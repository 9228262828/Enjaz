import '../../presentation/home/data/project_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Project> projects;

  SearchLoaded(this.projects);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}

class SearchFilteredLoading extends SearchState {}

class SearchFilteredLoaded extends SearchState {
  final List<Project> projects;

  SearchFilteredLoaded(this.projects);
}

class SearchFilteredError extends SearchState {
  final String message;

  SearchFilteredError(this.message);
}
