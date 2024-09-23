
import '../../presentation/home/data/privacy_model.dart';

abstract class PrivacyPolicyState {}

class PrivacyPolicyInitial extends PrivacyPolicyState {}

class PrivacyPolicyLoading extends PrivacyPolicyState {}

class PrivacyPolicyLoaded extends PrivacyPolicyState {
  final PrivacyPolicyModel privacyPolicy;

  PrivacyPolicyLoaded(this.privacyPolicy);
}

class PrivacyPolicyError extends PrivacyPolicyState {
  final String error;

  PrivacyPolicyError(this.error);
}


abstract class TermsAndConditionsState {}

class TermsAndConditionsInitial extends TermsAndConditionsState {}

class TermsAndConditionsLoading extends TermsAndConditionsState {}

class TermsAndConditionsLoaded extends TermsAndConditionsState {
  final TermsAndConditionsModel termsAndConditions;

  TermsAndConditionsLoaded(this.termsAndConditions);
}

class TermsAndConditionsError extends TermsAndConditionsState {
  final String errorMessage;

  TermsAndConditionsError(this.errorMessage);
}

abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}

class AboutUsLoading extends AboutUsState {}

class AboutUsLoaded extends AboutUsState {
  final AboutUs  aboutUs ;

  AboutUsLoaded(this.aboutUs);
}

class AboutUsError extends AboutUsState {
  final String errorMessage;

  AboutUsError(this.errorMessage);
}
