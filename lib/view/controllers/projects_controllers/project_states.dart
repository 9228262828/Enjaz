// lib/controllers/projects_controllers/project_states.dart

import '../../presentation/home/data/project_model.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {
  final int page;

  ProjectLoading({required this.page});
}
class ProjectLoaded extends ProjectState {
  final int page;
  final bool hasReachedMax;
  final List<Project> projects;
  final int projectId;

  ProjectLoaded({
    required this.page,
    required this.hasReachedMax,
    required this.projects,
    required this.projectId, // Track the current projectId
  });
}


class ProjectError extends ProjectState {
  final String message;

  ProjectError({required this.message});
}
//

abstract class AllProjectState {}

class AllProjectInitial extends AllProjectState {}

class AllProjectLoading extends AllProjectState {
  final int page;

  AllProjectLoading({required this.page});
}

class AllProjectLoaded extends AllProjectState {
  final List<Project> projects;
  final int page;
  final bool hasReachedMax;

  AllProjectLoaded({
    required this.projects,
    required this.page,
    required this.hasReachedMax,
  });
}

class AllProjectError extends AllProjectState {
  final String message;

  AllProjectError({required this.message});
}

abstract class AllProjectsFeaturedState {}

class AllProjectsFeaturedInitial extends AllProjectsFeaturedState {}

class AllProjectsFeaturedLoading extends AllProjectsFeaturedState {
  final int page;

  AllProjectsFeaturedLoading({required this.page});
}

class AllProjectsFeaturedLoaded extends AllProjectsFeaturedState {
  final List<Project> projects;
  final int page;
  final bool hasReachedMax;

  AllProjectsFeaturedLoaded({
    required this.projects,
    required this.page,
    required this.hasReachedMax,
  });
}

class AllProjectsFeaturedError extends AllProjectsFeaturedState {
  final String message;

  AllProjectsFeaturedError({required this.message});
}
