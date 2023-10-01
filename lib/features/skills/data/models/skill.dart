class Skill {
  final String id;
  final String name;
  final String imageUrl;

  Skill({required this.id, required this.name, required this.imageUrl});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}
