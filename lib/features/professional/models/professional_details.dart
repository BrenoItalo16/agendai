import 'package:agendai/features/professional/models/insurance.dart';
import 'package:agendai/features/professional/models/service.dart';
import 'package:agendai/features/professional/models/specialty.dart';

class ProfessionalDetails {
  const ProfessionalDetails({
    required this.id,
    required this.name,
    this.picture,
    required this.rating,
    required this.ratingCount,
    required this.address,
    required this.phone,
    required this.crm,
    required this.services,
    required this.specialties,
    required this.insurances,
  });

  factory ProfessionalDetails.fromMap(Map<String, dynamic> map) {
    return ProfessionalDetails(
      id: map['id'] as String,
      name: map['name'] as String,
      picture: map['picture'] as String,
      rating: map['rating'] as num,
      ratingCount: map['ratingCount'] as int,
      address: map['address'] as String,
      phone: map['phone'] as String,
      crm: map['crm'] as String,
      services:
          map['services'].map<Service>((s) => Service.fromJson(s)).toList(),
      specialties: map['specialties']
          .map<Specialty>((s) => Specialty.fromJson(s))
          .toList(),
      insurances: map['insurances']
          .map<Insurance>((s) => Insurance.fromJson(s))
          .toList(),
    );
  }

  final String id;
  final String name;
  final String? picture;
  final num rating;
  final int ratingCount;
  final String address;
  final String phone;
  final String crm;
  final List<Service> services;
  final List<Specialty> specialties;
  final List<Insurance> insurances;
}
