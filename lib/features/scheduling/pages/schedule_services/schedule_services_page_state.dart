part of 'schedule_services_page_cubit.dart';

class ScheduleServicesPageState extends Equatable {
  ScheduleServicesPageState({
    required this.selectedMonth,
    this.professional,
    this.loading = false,
    required this.selectedServices,
  });

  ScheduleServicesPageState.initial()
      : selectedMonth = DateTime(
          DateTime.now().year,
          DateTime.now().month,
        ),
        professional = null,
        loading = false,
        selectedServices = [];

  final DateTime selectedMonth;
  final DateTime firstAvailableDay = DateTime.now();
  final ProfessionalDetails? professional;
  final bool loading;
  final List<Service> selectedServices;

  List<DateTime> get availableMonths {
    Set<DateTime> months = {};
    for (int i = 0; i < 120; i++) {
      final day = firstAvailableDay.add(Duration(days: i));
      months.add(DateTime(day.year, day.month));
    }
    return months.toList();
  }

  DateTime get lastAvailableDay =>
      firstAvailableDay.add(const Duration(days: 120));

  @override
  List<Object?> get props =>
      [selectedMonth, loading, professional, selectedServices];

  ScheduleServicesPageState copyWith({
    DateTime? selectedMonth,
    ProfessionalDetails? professional,
    bool? loading,
    List<Service>? selectedServices,
  }) {
    return ScheduleServicesPageState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      professional: professional ?? this.professional,
      loading: loading ?? this.loading,
      selectedServices: selectedServices ?? this.selectedServices,
    );
  }

  ScheduleServicesPageState copyAddingService(Service service) {
    final services = List<Service>.from(selectedServices);
    services.add(service);
    return copyWith(selectedServices: services);
  }

  ScheduleServicesPageState copyRemovingService(Service service) {
    final services = List<Service>.from(selectedServices);
    services.remove(service);
    return copyWith(selectedServices: services);
  }
}
