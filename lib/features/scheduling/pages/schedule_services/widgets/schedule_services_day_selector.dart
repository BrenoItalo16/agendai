import 'package:agendai/core/theme/app_theme.dart';
import 'package:agendai/core/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

class ScheduleServicesDaySelector extends StatefulWidget {
  const ScheduleServicesDaySelector({Key? key}) : super(key: key);

  @override
  State<ScheduleServicesDaySelector> createState() =>
      _ScheduleServicesDaySelectorState();
}

class _ScheduleServicesDaySelectorState
    extends State<ScheduleServicesDaySelector> {
  final PageController pageController = PageController();
  int currentPage = 0;

  final currentMonth = DateTime(2023, 10);
  final today = DateTime.now();

  List<CalendarDay> days = [];

  CalendarDay? selectedDay;

  @override
  void initState() {
    super.initState();

    createDays();
  }

  void createDays() {
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
      days.add(CalendarDay(
          dateTime: monthDay,
          selectable:
              !monthDay.isBefore(today.subtract(const Duration(days: 1)))));
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
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    Color getDayTextColor(CalendarDay day) {
      if (!day.selectable) {
        return theme.grey;
      } else if (day == selectedDay) {
        return theme.white;
      } else {
        return theme.txtColor;
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
            // iconPath: 'assets/icons/chevron_left.svg',
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
                            pageDays.contains(selectedDay);

                        return Stack(
                          children: [
                            if (selectedDayInView)
                              AnimatedPositioned(
                                left:
                                    itemWidth * pageDays.indexOf(selectedDay!),
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
                                      onTap: day.selectable
                                          ? () {
                                              setState(() {
                                                selectedDay = day;
                                              });
                                            }
                                          : null,
                                      borderRadius: BorderRadius.circular(14),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            day.dateTime.day
                                                .toString()
                                                .padLeft(2, '0'),
                                            style: theme.heading20Bold.copyWith(
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

class CalendarDay {
  CalendarDay({required this.dateTime, required this.selectable});

  final DateTime dateTime;
  final bool selectable;

  @override
  String toString() {
    return 'CalendarDay{dateTime: $dateTime, selectable: $selectable}';
  }
}
