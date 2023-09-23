import 'package:agendai/features/professional/models/professional.dart';
import 'package:agendai/features/professional/models/service.dart';

class Scheduling {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final Professional professional;
  final List<Service> services;

  const Scheduling({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.professional,
    required this.services,
  });

  factory Scheduling.fromMap(Map<String, dynamic> map) {
    return Scheduling(
      id: map['id'] as String,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      professional: Professional.fromJson(map['professional']),
      services:
          map['services'].map<Service>((s) => Service.fromJson(s)).toList(),
    );
  }
}
