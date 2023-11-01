class Insurance {
  const Insurance({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  factory Insurance.fromJson(Map<String, dynamic> map) {
    return Insurance(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
