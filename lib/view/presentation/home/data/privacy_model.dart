class PrivacyPolicyModel {
  final int id;
  final String title;
  final String content;

  PrivacyPolicyModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
class TermsAndConditionsModel {
  final int id;
  final String title;
  final String content;

  TermsAndConditionsModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    return TermsAndConditionsModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}

class AboutUs {
  final int id;
  final String title;
  final String content;

  AboutUs({
    required this.id,
    required this.title,
    required this.content,
  });

  factory AboutUs.fromJson(Map<String, dynamic> json) {
    return AboutUs(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
