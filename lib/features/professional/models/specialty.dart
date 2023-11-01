class Specialty {
  const Specialty({
    required this.id,
    required this.name,
  });

  factory Specialty.fromJson(Map<String, dynamic> map) {
    return Specialty(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  final String id;
  final String name;
}
