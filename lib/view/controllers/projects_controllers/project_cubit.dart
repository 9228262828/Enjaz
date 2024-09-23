import 'package:bloc/bloc.dart';
import 'package:enjaz/view/controllers/projects_controllers/project_states.dart';
import '../../../shared/network/dio_helper.dart';
import '../../presentation/home/data/project_model.dart';


class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitial());

  final int count = 10; // Fixed count to 10

  Future<void> fetchProjects({
    bool isInitial = false,
    required int projectId,
    required int pageCount
  }) async {
    if (isInitial || state is! ProjectLoaded || (state is ProjectLoaded && (state as ProjectLoaded).projectId != projectId)) {

      emit(ProjectLoading(page: 1));
    }

    try {
      final List<Project> allProjects = [];
      bool fetchMore = true;
      int currentPage = 1; // Set page to 1

      while (fetchMore) {
        final response = await DioHelper.getData(
          url: 'https://www.enjazproperty.com/wp-json/wp/v2/property/$count/developer/$projectId',
          query: {'count': count, 'page': currentPage},
        );

        if (response.statusCode == 404) {
          emit(ProjectError(message: 'No posts found'));
          return;
        }

        final List<dynamic> data = response.data ?? [];

        if (data is List) {
          final List<Project> newProjects = data.map((item) => Project.fromJson(item)).toList();
          allProjects.addAll(newProjects);

          // Determine if we need to fetch more
          fetchMore = newProjects.length == count && currentPage < pageCount;

          currentPage++; // Increment page for the next request
        }
        else {
          // Handle unexpected response format
          emit(ProjectError(message: 'Unexpected response format'));
          return;
        }
      }

      // Emit all projects when done
      emit(ProjectLoaded(
        page: 1, // Always 1 since page is fixed
        hasReachedMax: false, // Not using hasReachedMax anymore
        projects: allProjects,
        projectId: projectId,
      ));
    } catch (error) {
      print(error);
      emit(ProjectError(message: error.toString()));
    }
  }
}


class AllProjectCubit extends Cubit<AllProjectState> {
  int page = 1;
  final int count = 10;
  bool hasReachedMax = false;
  List<Project> projects = [];

  AllProjectCubit() : super(AllProjectInitial()) {
    fetchProjects(isInitial: true);
  }

  Future<void> fetchProjects({bool isInitial = false}) async {
    if (isInitial) {
      page = 1;
      hasReachedMax = false;
      projects = [];
      emit(AllProjectLoading(page: page));
    }

    if (hasReachedMax) return;

    try {
      final response = await DioHelper.getData(
        url: 'https://www.enjazproperty.com/wp-json/wp/v2/property/$page',
        query: {'count': count, 'page': page},
      );

      final List<dynamic> data = response.data;
      List<Project> newProjects = data
          .map((json) => Project.fromJson(json))
          .toList();

      if (newProjects.length < count) {
        hasReachedMax = true;
      }

      projects.addAll(newProjects);
      emit(AllProjectLoaded(
        projects: projects,
        page: page,
        hasReachedMax: hasReachedMax,
      ));
      page++;
    } catch (error) {
      emit(AllProjectError(message: error.toString()));
    }
  }

  void loadMoreProjects() {
    if (!hasReachedMax) {
      fetchProjects();
    }
  }
}

class AllProjectsFeaturedCubit extends Cubit<AllProjectsFeaturedState> {
  int page = 1;
  final int count = 10;
  bool hasReachedMax = false;
  List<Project> projects = [];

  AllProjectsFeaturedCubit() : super(AllProjectsFeaturedInitial()) {
    fetchFeaturedProjects(isInitial: true);
  }

  Future<void> fetchFeaturedProjects({bool isInitial = false}) async {
    if (isInitial) {
      page = 1;
      hasReachedMax = false;
      projects = [];
      emit(AllProjectsFeaturedLoading(page: page));
    }

    if (hasReachedMax) return;

    try {
      final response = await DioHelper.getData(
        url: 'https://enjazproperty.com/wp-json/wp/v2/property/1/featured',
        query: {'count': count, 'page': page},
      );

      final List<dynamic> data = response.data;
      List<Project> newProjects = data
          .map((json) => Project.fromJson(json))
          .toList();

      if (newProjects.length < count) {
        hasReachedMax = true;
      }

      projects.addAll(newProjects);
      emit(AllProjectsFeaturedLoaded(
        projects: projects,
        page: page,
        hasReachedMax: hasReachedMax,
      ));
      page++;
    } catch (error) {
      emit(AllProjectsFeaturedError(message: error.toString()));
    }
  }

  void loadMoreProjects() {
    if (!hasReachedMax) {
      fetchFeaturedProjects();
    }
  }
}
