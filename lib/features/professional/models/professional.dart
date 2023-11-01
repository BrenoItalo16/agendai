class Professional {
  const Professional({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Professional.fromJson(Map<String, dynamic> map) {
    return Professional(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
