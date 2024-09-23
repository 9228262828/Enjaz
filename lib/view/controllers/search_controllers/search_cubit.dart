import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:enjaz/shared/network/dio_helper.dart';
import 'package:enjaz/view/controllers/search_controllers/search_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/home/data/project_model.dart';
import '../../presentation/home/screens/advanced_search_screen.dart';


class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchProjects(String name) async {
    emit(SearchLoading());
    try {
      final response = await DioHelper.postData(
        url: 'https://www.enjazproperty.com/wp-json/wp/v2/property/filter?count=10',
        data: FormData.fromMap({
          'page': 1,
          's': name,
        }),
      );

      // Log the response data for debugging
      print('Response Data: ${response.data}');

      final List<Project> allProjects = [];
      final List<dynamic> data = response.data ?? [];

      // Check for 404 status code in the response
      if (response.statusCode == 404) {
        emit(SearchError('لا يوجد الان'));
        return; // Exit early since there's no data to process
      }

      // Check if the response is a List
      if (data is List) {
        final List<Project> newProjects = [];
        for (var item in data) {
          // Check if the item is a Map<String, dynamic>
          if (item is Map<String, dynamic>) {
            newProjects.add(Project.fromJson(item));
          } else {
            // Log or handle unexpected item format
            print('Unexpected item format: $item');
          }
        }

        allProjects.addAll(newProjects);
        emit(SearchLoaded(newProjects));
      } else {
        emit(SearchError('Unexpected response format.'));
      }

      await _saveLastSearch(name);
    } catch (e) {
      // Check if it's a DioError and handle 404 specifically
      if (e is DioError && e.response?.statusCode == 404) {
        emit(SearchError('لا يوجد الان'));
      } else {
        print('Search Error: $e');
        emit(SearchError('لا يوجد مشاريع بهذا الاسم, من فضلك قم بالبحث مرة اخرى'));
      }
    }
  }

  Future<void> searchFilteredProjects({
  required String name,
  required String type,
  required String city
}) async {
    emit(SearchFilteredLoading());
    try {
      final response = await DioHelper.postData(
        url: 'https://www.enjazproperty.com/wp-json/wp/v2/property/filter?count=10',
        data: FormData.fromMap({
          'page': 1,
          's': name,
          'type': type,
          'city': city
        }),
      );

      // Log the response data for debugging
      print('Response Data: ${response.data}');

      final List<Project> allProjects = [];
      final List<dynamic> data = response.data ?? [];

      // Check for 404 status code in the response
      if (response.statusCode == 404) {
        emit(SearchFilteredError('لا يوجد الان'));
        return; // Exit early since there's no data to process
      }

      // Check if the response is a List
      if (data is List) {
        final List<Project> newProjects = [];
        for (var item in data) {
          // Check if the item is a Map<String, dynamic>
          if (item is Map<String, dynamic>) {
            newProjects.add(Project.fromJson(item));
          } else {
            // Log or handle unexpected item format
            print('Unexpected item format: $item');
          }
        }

        allProjects.addAll(newProjects);
        emit(SearchFilteredLoaded(newProjects));
      } else {
        emit(SearchFilteredError('Unexpected response format.'));
      }

      await _saveLastSearch(name);
    } catch (e) {
      // Check if it's a DioError and handle 404 specifically
      if (e is DioError && e.response?.statusCode == 404) {
        emit(SearchFilteredError('لا يوجد الان'));
      } else {
        print('Search Error: $e');
        emit(SearchFilteredError('لا يوجد مشاريع بهذا الاسم, من فضلك قم بالبحث مرة اخرى'));
      }
    }
  }



Future<void> _saveLastSearch(String query) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> lastSearches = prefs.getStringList('last_searches') ?? [];

  // Add the new search query and limit to 5 items
  if (!lastSearches.contains(query)) {
    lastSearches.add(query);
    if (lastSearches.length > 5) {
      lastSearches.removeAt(0); // Remove the oldest search
    }
  }

  await prefs.setStringList('last_searches', lastSearches);
}

Future<List<String>> getLastSearches() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('last_searches') ?? [];
}

  Future<List<ProjectType>> fetchProjectTypes() async {
    const String url = 'https://enjazproperty.com/wp-json/wp/v2/property/taxonomy/1/types';
    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((item) => ProjectType.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load project types');
    }
  }

}