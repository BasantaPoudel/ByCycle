import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:by_cycle/models/calendar_utils.dart';

class Event {
  DateTime startDate;
  DateTime endDate;

  Event({required this.startDate, required this.endDate});
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Event event = Event(
    startDate: DateTime.now().subtract(Duration(days: 1)),
    endDate: DateTime.now().add(Duration(days: 1)),
  );

  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.enforced;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<DateTimeRange> dateTimeRanges = [];
  CalendarStyle style = const CalendarStyle();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTimeRange? dayInRange(DateTime day) {
    List<DateTimeRange> list = dateTimeRanges
        .where((element) =>
            element.start.isBefore(day) && element.end.isAfter(day) ||
            (element.start.year == day.year &&
                element.start.month == day.month &&
                element.start.day == day.day) ||
            (element.end.year == day.year &&
                element.end.month == day.month &&
                element.end.day == day.day))
        .toList();
    return list.isNotEmpty ? list[0] : null;
  }

// Checks if a day is between two days
  bool isInRange(DateTime day, DateTime start, DateTime end) {
    if (isSameDay(day, start) || isSameDay(day, end)) {
      return true;
    }

    if (day.isAfter(start) && day.isBefore(end)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final customCalendarStyle = CalendarStyle(
      rangeHighlightColor:
          Colors.blue.withOpacity(0.5), // Change this to your desired color
      rangeStartDecoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      rangeEndDecoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      withinRangeDecoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
      ),
      rangeStartTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      rangeEndTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      withinRangeTextStyle: TextStyle(
        color: Colors.black,
      ),
      cellMargin: EdgeInsets.all(4.0),
      canMarkersOverflow: true,
      markersAlignment: Alignment.center,
      rangeHighlightScale: 1.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: TableCalendar(
        firstDay: DateTime(2020, 1, 1),
        lastDay: DateTime(2025, 1, 1),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        rangeStartDay: event.startDate,
        rangeEndDay: event.endDate,
        rangeSelectionMode: rangeSelectionMode,
        // CalendarBuilders with null safety applied
        calendarStyle: customCalendarStyle,
        calendarBuilders: CalendarBuilders(
          prioritizedBuilder: (context, day, focusedMonth) {
            DateTimeRange? dateTimeRange = dayInRange(day);

            // If day is in any saved DateTimeRange, show a highlighted cell
            if (dateTimeRange != null) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final shorterSide =
                      constraints.maxHeight > constraints.maxWidth
                          ? constraints.maxWidth
                          : constraints.maxHeight;

                  final children = <Widget>[];

                  final isWithinRange = dateTimeRange.start != null &&
                      dateTimeRange.end != null &&
                      isInRange(day, dateTimeRange.start, dateTimeRange.end);

                  final isRangeStart = isSameDay(day, dateTimeRange.start);
                  final isRangeEnd = isSameDay(day, dateTimeRange.end);

                  if (isWithinRange) {
                    Widget rangeHighlight = Center(
                      child: Container(
                        margin: EdgeInsetsDirectional.only(
                          start:
                              isRangeStart ? constraints.maxWidth * 0.5 : 0.0,
                          end: isRangeEnd ? constraints.maxWidth * 0.5 : 0.0,
                        ),
                        height: (shorterSide - style.cellMargin.vertical) *
                            style.rangeHighlightScale,
                        color: style.rangeHighlightColor,
                      ),
                    );
                    children.add(rangeHighlight);
                  }

                  Widget? content;

                  if (isRangeStart) {
                    content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: style.cellMargin,
                      decoration: style.rangeStartDecoration,
                      alignment: Alignment.center,
                      child:
                          Text('${day.day}', style: style.rangeStartTextStyle),
                    );
                  } else if (isRangeEnd) {
                    content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: style.cellMargin,
                      decoration: style.rangeEndDecoration,
                      alignment: Alignment.center,
                      child: Text('${day.day}', style: style.rangeEndTextStyle),
                    );
                  } else if (isWithinRange) {
                    content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: style.cellMargin,
                      decoration: style.withinRangeDecoration,
                      alignment: Alignment.center,
                      child:
                          Text('${day.day}', style: style.withinRangeTextStyle),
                    );
                  }

                  if (content != null) {
                    children.add(content);
                  }

                  return Stack(
                    alignment: style.markersAlignment,
                    children: children,
                    clipBehavior:
                        style.canMarkersOverflow ? Clip.none : Clip.hardEdge,
                  );
                },
              );
            }
            return null;
          },
        ),
        onDaySelected: (selDay, focDay) {
          if (!isSameDay(_selectedDay, selDay)) {
            setState(() {
              _selectedDay = selDay;
              _focusedDay = focDay;
              event.startDate = DateTime.now().subtract(Duration(days: 2));
              event.endDate = DateTime.now().add(Duration(days: 2));
              rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          }
        },
        onRangeSelected: (start, end, focDay) {
          setState(() {
            _selectedDay = focDay;
            _focusedDay = focDay;
            event.startDate = start ?? event.startDate;
            event.endDate = end ?? event.endDate;

            bool startDateInRange = false;
            bool endDateInRange = false;

            DateTimeRange? range = dayInRange(event.startDate);

            if (range == null && event.endDate != null) {
              range = dayInRange(event.endDate);
              if (range != null) {
                endDateInRange = true;
              }
            } else if (range != null) {
              startDateInRange = true;
              if (event.endDate != null && dayInRange(event.endDate) != null) {
                endDateInRange = true;
              }
            }

            bool insertNewRange = true;

            if (startDateInRange) {
              if (isInRange(event.startDate, range!.start, range.end)) {
                int index = dateTimeRanges.indexOf(range);
                if (!endDateInRange && event.endDate != null) {
                  dateTimeRanges[index] =
                      DateTimeRange(start: event.startDate, end: event.endDate);
                } else {
                  dateTimeRanges[index] =
                      DateTimeRange(start: event.startDate, end: range.end);
                }
                insertNewRange = false;
              }
            }

            if (endDateInRange) {
              if (isInRange(event.endDate, range!.start, range.end)) {
                print("enddate is not null and is in range");
                int index = dateTimeRanges.indexOf(range);
                dateTimeRanges[index] =
                    DateTimeRange(start: event.startDate, end: event.endDate);
                insertNewRange = false;
              }
            }

            if (insertNewRange) {
              dateTimeRanges.add(
                  DateTimeRange(start: event.startDate, end: event.endDate));
              dateTimeRanges.add(DateTimeRange(
                  start: event.startDate.subtract(Duration(days: 6)),
                  end: event.endDate.subtract(Duration(days: 6))));
              dateTimeRanges.add(DateTimeRange(
                  start: event.startDate.add(Duration(days: 6)),
                  end: event.endDate.add(Duration(days: 6))));
            }
          });
        },

        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
