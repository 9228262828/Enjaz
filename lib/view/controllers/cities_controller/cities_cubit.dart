import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../shared/network/dio_helper.dart';
import '../../presentation/home/data/cities.dart';
import '../../presentation/home/data/project_model.dart';
import 'cities_states.dart';

class CitiesCubit extends Cubit<CitiesState> {
  int page = 1;
  final int count = 10;
  bool hasReachedMax = false;
  List<Cities> Citiess = [];

  CitiesCubit() : super(CitiesInitial()) {
    fetchCitiess(isInitial: true);
  }

  Future<void> fetchCitiess({bool isInitial = false}) async {
    if (isInitial) {
      page = 1;
      hasReachedMax = false;
      Citiess = [];
      emit(CitiesLoading(page: page));
    }

    if (hasReachedMax) return;

    try {
      final response = await DioHelper.getData(
        url:
            'https://www.enjazproperty.com/wp-json/wp/v2/property/taxonomy/$page/cities',
        query: {'count': count, 'page': page},
        token: '',
      );

      final List<dynamic> data = response.data;
      List<Cities> newCitiess =
          data.map((json) => Cities.fromJson(json)).toList();

      if (newCitiess.length < count) {
        hasReachedMax = true;
      }

      Citiess.addAll(newCitiess);
      emit(CitiesLoaded(
          cites: Citiess, page: page, hasReachedMax: hasReachedMax));
      page++;
    } catch (error) {
      print(error);
      emit(CitiesError(message: error.toString()));
    }
  }
}

class CitiesAllCubit extends Cubit<CitiesAllState> {
  final int count = 10; // Fixed count to 10

  CitiesAllCubit() : super(CitiesAllInitial());

  Future<void> fetchCitiesProjects({
    bool isInitial = false,
    required int projectId,
    required int pageCount,
  }) async {
    if (isInitial || state is! CitiesAllLoaded || (state is CitiesAllLoaded && (state as CitiesAllLoaded).projectId != projectId)) {
      emit(CitiesAllLoading(page: 1));
    }

    try {
      final List<Project> allProjects = [];
      bool fetchMore = true;
      int currentPage = 1; // Set page to 1

      while (fetchMore) {
        final response = await DioHelper.getData(
          url: 'https://www.enjazproperty.com/wp-json/wp/v2/property/$count/property-city/$projectId',
          query: {'count': count, 'page': currentPage},
        );

        if (response.statusCode == 404) {
          emit(CitiesAllError(message: 'No posts found'));
          return;
        }

        final List<dynamic> data = response.data ?? [];

        if (data is List) {
          final List<Project> newProjects = data.map((item) => Project.fromJson(item)).toList();

          // Append newly fetched projects to the list
          allProjects.addAll(newProjects);

          // Emit the current list of projects
          emit(CitiesAllLoaded(
            page: currentPage, // Update page number
            hasReachedMax: false, // Determine this later
            projects: allProjects,
            projectId: projectId,
          ));

          // Determine if we need to fetch more
          fetchMore = newProjects.length == count && currentPage < pageCount;

          currentPage++; // Increment page for the next request
        } else {
          // Handle unexpected response format
          emit(CitiesAllError(message: 'Unexpected response format'));
          return;
        }
      }

      // Final emit after all data is fetched
      emit(CitiesAllLoaded(
        page: 1, // Always 1 since page is fixed
        hasReachedMax: true, // All data is loaded
        projects: allProjects,
        projectId: projectId,
      ));
    } catch (error) {
      print(error);
      emit(CitiesAllError(message: error.toString()));
    }
  }
}
