import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alert_area_state.dart';

class AlertAreaCubit extends Cubit<AlertAreaState> {
  AlertAreaCubit() : super(AlertAreaState(number: Random().nextInt(10000000)));

  void showAlert(Alert alert) {
    emit(AlertAreaState(
        alerts: [alert, ...state.alerts], number: Random().nextInt(10000000)));
  }

  void removeAlert(Alert alert) {
    final alerts = state.alerts;
    final index = alerts.indexOf(alert);
    alerts.removeAt(index);
    emit(AlertAreaState(
        alerts: [...alerts], number: Random().nextInt(10000000)));
  }
}

class Alert extends Equatable {
  const Alert.success(
      {required this.title, this.duration = const Duration(seconds: 2)})
      : type = AlertType.success;
  const Alert.error(
      {required this.title, this.duration = const Duration(seconds: 2)})
      : type = AlertType.error;

  final String title;
  final AlertType type;
  final Duration duration;

  @override
  List<Object?> get props => [title, type, duration];
}

enum AlertType { success, error }
