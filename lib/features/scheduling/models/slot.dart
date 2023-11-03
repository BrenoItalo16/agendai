import 'package:equatable/equatable.dart';

class Slot extends Equatable {
  const Slot({required this.startDate, required this.endDate});

  final DateTime startDate;
  final DateTime endDate;

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  @override
  List<Object?> get props => [startDate, endDate];
}
