import '../../../shared/network/dio_helper.dart';
import '../../presentation/home/data/developer_model.dart';
import 'developers_states.dart';
import 'package:bloc/bloc.dart';

class DeveloperCubit extends Cubit<DeveloperState> {
  int page = 1;
  final int count = 10;
  bool hasReachedMax = false;
  List<Developer> developers = [];

  DeveloperCubit() : super(DeveloperInitial()) {
    fetchDevelopers(isInitial: true);
  }

  Future<void> fetchDevelopers({bool isInitial = false}) async {
    if (isInitial) {
      page = 1;
      hasReachedMax = false;
      developers = [];
      emit(DeveloperLoading(page: page));
    }

    if (hasReachedMax) return;

    try {
      final response = await DioHelper.getData(
        url:
        'https://www.enjazproperty.com/wp-json/wp/v2/property/taxonomy/1/developers',
        query: {'count': count, 'page': page},
        token: '',
      );

      final List<dynamic> data = response.data;
      List<Developer> newDevelopers =
      data.map((json) => Developer.fromJson(json)).toList();

      if (newDevelopers.length < count) {
        hasReachedMax = true;
      }

      developers.addAll(newDevelopers);
      emit(DeveloperLoaded(developers: developers, page: page, hasReachedMax: hasReachedMax));
      page++;
    } catch (error) {
      print(error);
      emit(DeveloperError(message: error.toString()));
    }
  }
}


class DevelopersFeaturedCubit extends Cubit<DevelopersFeaturedState> {
  int page = 1;
  final int count = 10;
  bool hasReachedMax = false;
  List<Developer> developers = [];

  DevelopersFeaturedCubit() : super(DevelopersFeaturedInitial()) {
    fetchFeaturedDevelopers(isInitial: true);
  }

  Future<void> fetchFeaturedDevelopers({bool isInitial = false}) async {
    if (isInitial) {
      page = 1;
      hasReachedMax = false;
      developers = [];
      emit(DevelopersFeaturedLoading(page: page));
    }

    if (hasReachedMax) return;

    try {
      final response = await DioHelper.getData(
        url:
        "https://enjazproperty.com/wp-json/wp/v2/property/developers/1/featured",
        query: {'count': count, 'page': page},
        token: '',
      );

      final List<dynamic> data = response.data;
      List<Developer> newDevelopers =
      data.map((json) => Developer.fromJson(json)).toList();

      if (newDevelopers.length < count) {
        hasReachedMax = true;
      }

      developers.addAll(newDevelopers);
      emit(DevelopersFeaturedLoaded(developers: developers, page: page, hasReachedMax: hasReachedMax));
      page++;
    } catch (error) {
      print(error);
      emit(DevelopersFeaturedError(message: error.toString()));
    }
  }
}
