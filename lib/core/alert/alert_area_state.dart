part of 'alert_area_cubit.dart';

class AlertAreaState extends Equatable {
  AlertAreaState({List<Alert>? alerts, required this.number})
      : alerts = alerts ?? [];

  final List<Alert> alerts;
  final int number;

  @override
  List<Object> get props => [alerts, number];
}
