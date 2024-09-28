import 'package:bloc/bloc.dart';
import 'package:enjaz/view/controllers/settings_controller/privacy_states.dart';
import 'package:html/parser.dart';  // For parsing HTML
import '../../../shared/network/dio_helper.dart';
import '../../presentation/home/data/privacy_model.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  PrivacyPolicyCubit() : super(PrivacyPolicyInitial());

  Future<void> fetchPrivacyPolicy() async {
    emit(PrivacyPolicyLoading());
    try {
      final response = await DioHelper.getData(
        url: 'https://enjazproperty.com/wp-json/wp/v2/privacy-policy',
      );
      final data = PrivacyPolicyModel.fromJson(response.data);

      // Strip HTML tags from the content
      final String strippedContent = parseHtmlString(data.content);

      // Update the model with the stripped content
      final strippedData = PrivacyPolicyModel(
        id: data.id,
        title: data.title,
        content: strippedContent,
      );

      emit(PrivacyPolicyLoaded(strippedData));
    } catch (error) {
      emit(PrivacyPolicyError(error.toString()));
    }
  }
}

String parseHtmlString(String htmlString) {
  var document = parse(htmlString);
  return parse(document.body!.text).documentElement!.text;  // Strips all HTML tags
}

class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  TermsAndConditionsCubit() : super(TermsAndConditionsInitial());

  Future<void> fetchTermsAndConditions() async {
    emit(TermsAndConditionsLoading());
    try {
      final response = await DioHelper.getData(
        url: 'https://enjazproperty.com/wp-json/wp/v2/terms-and-conditions',
      );
      final data = TermsAndConditionsModel.fromJson(response.data);

      // Strip HTML tags from the content
      final String strippedContent = parseHtmlString(data.content);

      // Update the model with the stripped content
      final strippedData = TermsAndConditionsModel(
        id: data.id,
        title: data.title,
        content: strippedContent,
      );

      emit(TermsAndConditionsLoaded(strippedData));
    } catch (error) {
      emit(TermsAndConditionsError(error.toString()));
    }
  }
}


class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());

  Future<void> fetchAboutUs() async {
    emit(AboutUsLoading());
    try {
      final response = await DioHelper.getData(
        url: 'https://enjazproperty.com/wp-json/wp/v2/aboutus',
      );
      final data = AboutUs.fromJson(response.data);

      final String strippedContent = parseHtmlString(data.content);

      // Update the model with the stripped content
      final strippedData = AboutUs(
        id: data.id,
        title: data.title,
        content: strippedContent,
      );

      emit(AboutUsLoaded(strippedData));
    } catch (error) {
      emit(AboutUsError(error.toString()));
    }
  }
}

