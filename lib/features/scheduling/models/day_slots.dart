import 'package:agendai/features/scheduling/models/slot.dart';

class DaySlots {
  const DaySlots({
    required this.date,
    required this.slots,
  });

  final DateTime date;
  final List<Slot> slots;

  factory DaySlots.fromMap(Map<String, dynamic> map) {
    return DaySlots(
      date: DateTime.parse(map['date']),
      slots: map['slots'].map<Slot>((s) => Slot.fromJson(s)).toList(),
    );
  }
}
