import 'package:agendai/core/di/di.dart';
import 'package:agendai/core/widgets/alert/alert_area_cubit.dart';
import 'package:agendai/core/widgets/alert/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertArea extends StatefulWidget {
  const AlertArea({Key? key}) : super(key: key);

  @override
  State<AlertArea> createState() => _AlertAreaState();
}

class _AlertAreaState extends State<AlertArea> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AlertAreaCubit>(),
      child: SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AlertAreaCubit, AlertAreaState>(
              builder: (context, state) {
                return Column(
                  children: [
                    for (final a in state.alerts) ...[
                      AlertWidget(
                        alert: a,
                        key: ObjectKey(a),
                      ),
                      if (state.alerts.indexOf(a) < state.alerts.length - 1)
                        const SizedBox(height: 8),
                    ]
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
