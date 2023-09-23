class Service {
  const Service({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
