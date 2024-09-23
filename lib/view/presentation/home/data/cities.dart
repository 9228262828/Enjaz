class Cities {
  final int id;
  final int count;
  final String name;
  final String description;
  final String image;

  Cities({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.count,
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['id'],
      count: json['count'],
      name: json['name'],
      description: json['description'],
      image: (json['image'] == null || json['image'] == false)
          ? 'assets/images/logo-b.png'
          : json['image'],
    );
  }
}