import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_icon_button.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class ScheduleServicesDaySelector extends StatefulWidget {
  const ScheduleServicesDaySelector({
    Key? key,
    required this.currentMonth,
    required this.lastDay,
    required this.onMonthChanged,
    required this.onRangeChanged,
  }) : super(key: key);

  final DateTime currentMonth;
  final DateTime lastDay;
  final Function(DateTime) onMonthChanged;
  final Function(DateTime, DateTime) onRangeChanged;

  @override
  State<ScheduleServicesDaySelector> createState() =>
      _ScheduleServicesDaySelectorState();
}

class _ScheduleServicesDaySelectorState
    extends State<ScheduleServicesDaySelector> {
  final PageController pageController = PageController();
  int currentPage = 0;

  DateTime get currentMonth => widget.currentMonth;

  final today = DateTime.now();

  List<CalendarDay> days = [];

  late DateTime selectedDay = DateUtils.dateOnly(today);

  @override
  void initState() {
    super.initState();

    createDays();
  }

  @override
  void didUpdateWidget(ScheduleServicesDaySelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentMonth != widget.currentMonth) {
      createDays();

      final currentDayIndex = days.indexWhere(
        (d) =>
            DateUtils.dateOnly(d.dateTime) == DateUtils.dateOnly(selectedDay),
      );

      currentPage = currentDayIndex ~/ 7;
      pageController.jumpToPage(currentPage);
    }
  }

  void createDays() {
    days.clear();

    final firstMonthWeekDay = currentMonth.weekday;
    if (firstMonthWeekDay != DateTime.monday) {
      for (int i = firstMonthWeekDay - 1; i >= 1; i--) {
        final lastMonthDay = currentMonth.subtract(Duration(days: i));
        days.add(
          CalendarDay(dateTime: lastMonthDay, selectable: false),
        );
      }
    }

    for (int day = 0;
        day < DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
        day++) {
      final monthDay = currentMonth.add(Duration(days: day));
      final isAvailable = monthDay.isBefore(widget.lastDay) &&
          !monthDay.isBefore(today.subtract(const Duration(days: 1)));
      days.add(CalendarDay(dateTime: monthDay, selectable: isAvailable));
    }

    final lastMonthDay = days.last.dateTime;
    final lastMonthWeekDay = lastMonthDay.weekday;
    if (lastMonthWeekDay != DateTime.sunday) {
      for (int i = 1; i <= DateTime.daysPerWeek - lastMonthWeekDay; i++) {
        final nextMonthDay = lastMonthDay.add(Duration(days: i));
        days.add(
          CalendarDay(dateTime: nextMonthDay, selectable: false),
        );
      }
    }

    final currentDayIndex = days.indexWhere(
      (d) => DateUtils.dateOnly(d.dateTime) == DateUtils.dateOnly(today),
    );
    final beforePages = currentDayIndex ~/ 7;
    days.removeRange(0, beforePages * 7);
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    Color getDayTextColor(CalendarDay day) {
      if (!day.selectable) {
        return theme.grey;
      } else if (day.dateTime == selectedDay) {
        return theme.white;
      } else {
        return theme.black;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: [
          AppIconButton(
            size: 40,
            id: 'mes-anterior',
            icon: IconlyBold.arrow_left_2,
            onPressed: currentPage > 0
                ? () {
                    pageController.animateToPage(
                      currentPage - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                : null,
          ),
          Expanded(
            child: SizedBox(
              height: 60,
              child: PageView(
                controller: pageController,
                onPageChanged: (p) {
                  setState(() {
                    currentPage = p;
                  });
                  final pageDays = days.getRange(p * 7, (p + 1) * 7).toList();
                  widget.onRangeChanged(
                      pageDays.first.dateTime, pageDays.last.dateTime);
                },
                children: [
                  for (int page = 0; page < days.length / 7; page++)
                    LayoutBuilder(
                      builder: (_, constraints) {
                        final pageDays =
                            days.getRange(page * 7, (page + 1) * 7).toList();

                        final width = constraints.maxWidth;
                        final itemWidth = (width) / 7;

                        final selectedDayInView =
                            pageDays.any((d) => d.dateTime == selectedDay);

                        return Stack(
                          children: [
                            if (selectedDayInView)
                              AnimatedPositioned(
                                left: itemWidth *
                                    pageDays.indexWhere(
                                        (d) => d.dateTime == selectedDay),
                                duration: const Duration(milliseconds: 300),
                                child: Container(
                                  width: itemWidth,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: theme.primary,
                                    borderRadius: BorderRadius.circular(
                                      14,
                                    ),
                                  ),
                                ),
                              ),
                            Row(
                              children: [
                                for (final day in pageDays)
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (day.selectable) {
                                          setState(() {
                                            selectedDay = day.dateTime;
                                          });
                                        } else {
                                          if (day.dateTime
                                                  .isBefore(widget.lastDay) &&
                                              day.dateTime.isAfter(today)) {
                                            widget.onMonthChanged(DateTime(
                                                day.dateTime.year,
                                                day.dateTime.month));
                                            setState(() {
                                              selectedDay = day.dateTime;
                                            });
                                          }
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(14),
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween<double>(begin: 0, end: 1),
                                        duration: const Duration(seconds: 1),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              day.dateTime.day
                                                  .toString()
                                                  .padLeft(2, '0'),
                                              style:
                                                  theme.heading20Bold.copyWith(
                                                color: getDayTextColor(day),
                                              ),
                                            ),
                                            Text(
                                              DateFormat('EEE')
                                                  .format(day.dateTime)
                                                  .toLowerCase(),
                                              style: theme.body13.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: getDayTextColor(day),
                                              ),
                                            )
                                          ],
                                        ),
                                        builder: (_, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: child,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          AppIconButton(
            size: 40,
            id: 'mes-anterior',
            icon: IconlyBold.arrow_right_2,
            onPressed: currentPage < days.length / 7 - 1
                ? () {
                    pageController.animateToPage(
                      currentPage + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class CalendarDay extends Equatable {
  const CalendarDay({required this.dateTime, required this.selectable});

  final DateTime dateTime;
  final bool selectable;

  @override
  String toString() {
    return 'CalendarDay{dateTime: $dateTime, selectable: $selectable}';
  }

  @override
  List<Object?> get props => [dateTime, selectable];
}
