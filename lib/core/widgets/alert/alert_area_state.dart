part of 'alert_area_cubit.dart';

class AlertAreaState extends Equatable {
  AlertAreaState({List<Alert>? alerts}) : alerts = alerts ?? [];

  final List<Alert> alerts;

  @override
  List<Object> get props => [alerts];
}
