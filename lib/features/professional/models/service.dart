class Service {
  const Service({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
  });

  final String id;
  final String name;
  final int duration;
  final num price;

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      name: map['name'] as String,
      duration: map['duration'] as int,
      price: map['price'] as num,
    );
  }
}
