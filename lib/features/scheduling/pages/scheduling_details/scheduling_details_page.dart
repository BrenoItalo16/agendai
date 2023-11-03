import 'package:flutter/material.dart';

class SchedulingDetailsPage extends StatefulWidget {
  const SchedulingDetailsPage({Key? key, required this.schedulingId})
      : super(key: key);

  final String schedulingId;

  @override
  State<SchedulingDetailsPage> createState() => _SchedulingDetailsPageState();
}

class _SchedulingDetailsPageState extends State<SchedulingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedulingId),
      ),
    );
  }
}
