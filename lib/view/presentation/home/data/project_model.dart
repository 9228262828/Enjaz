class Project {
  int? id;
  String? title;
  String? content;
  List<String>? yoastdescription;
  List<String>? rankmathdescription;
  List<String>? price;
  List<String>? shortprice;
  List<String>? space;
  List<String>? downpayment;
  List<String>? installment;
  List<String>? location;
  String? image;
  List<String>? gallery;
  Sections? sections;
  List<String>? video;
  bool? featured;

  Project({
    this.id,
    this.title,
    this.content,
    this.yoastdescription,
    this.rankmathdescription,
    this.price,
    this.shortprice,
    this.space,
    this.downpayment,
    this.installment,
    this.location,
    this.image,
    this.gallery,
    this.sections,
    this.video,
    this.featured,
  });

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    featured = json['featured'];

    // Handle 'yoastdescription' and similar fields
    yoastdescription = _parseStringList(json['yoastdescription']);
    rankmathdescription = _parseStringList(json['rankmathdescription']) ?? [];
    price = _parseStringList(json['price']);
    shortprice = _parseStringList(json['shortprice']);
    space = _parseStringList(json['space']);
    downpayment = _parseStringList(json['downpayment']);
    installment = _parseStringList(json['installment']);
    location = _parseStringList(json['location']);
    gallery = _parseStringList(json['gallery']);
    video = _parseStringList(json['video']);

    image = json['image']?? 'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

    sections =
        json['sections'] != null ? Sections.fromJson(json['sections']) : null;
  }

  List<String>? _parseStringList(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['featured'] = this.featured;
    data['yoastdescription'] = this.yoastdescription;
    data['rankmathdescription'] = this.rankmathdescription;
    data['price'] = this.price;
    data['shortprice'] = this.shortprice;
    data['space'] = this.space;
    data['downpayment'] = this.downpayment;
    data['installment'] = this.installment;
    data['location'] = this.location;
    data['image'] = this.image;
    data['gallery'] = this.gallery;
    if (this.sections != null) {
      data['sections'] = this.sections!.toJson();
    }
    data['video'] = this.video;
    return data;
  }
}

class Sections {
  City? city;
  Developer? developer;
  Type? type;

  Sections({this.city, this.developer, this.type});

  Sections.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    developer = json['developer'] != null
        ? Developer.fromJson(json['developer'])
        : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (developer != null) {
      data['developer'] = developer!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;

   String? image;

  City({
    this.id,
    this.name,
    this.image,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Developer {
  int? id;
  String? name;
  String? image;

  Developer({this.id, this.name,
    this.image
  });

  Developer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
   image = json['image']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Type {
  int? id;
  String? name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
class ProjectType {
  final int id;
  final String name;

  ProjectType({required this.id, required this.name});

  factory ProjectType.fromJson(Map<String, dynamic> json) {
    return ProjectType(
      id: json['id'],
      name: json['name'],
    );
  }
}

