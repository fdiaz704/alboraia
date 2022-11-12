class Post {
  String id;
  String name;
  String distance;
  String type;

  Post({
    required this.id,
    required this.name,
    required this.distance,
    required this.type,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      distance: json['distance'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
