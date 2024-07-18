import 'package:by_cycle/models/customDateTimeRange.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//a package from table calendar repository that turned out to be unneded
//import 'package:by_cycle/models/calendar_utils.dart';

class Calendar extends StatefulWidget {
  final List<CustomDateTimeRange>?
      initialDateTimeRanges; // Optional initial value

  Calendar({Key? key, this.initialDateTimeRanges}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.enforced;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late List<CustomDateTimeRange> dateTimeRanges;

  // Default CustomDateTimeRanges if none provided through constructor
  List<CustomDateTimeRange> _defaultDateTimeRanges = [
    CustomDateTimeRange(
      start: DateTime.now().add(Duration(days: 12)),
      end: DateTime.now().add(Duration(days: 14)),
    ),
    CustomDateTimeRange(
      start: DateTime.now().add(Duration(days: 3)),
      end: DateTime.now().add(Duration(days: 5)),
    ),
  ];
  CalendarStyle style = CalendarStyle(
    rangeHighlightColor: Color.fromRGBO(237, 195, 191, 1),
    rangeStartDecoration: BoxDecoration(
      color: Color.fromRGBO(237, 195, 191, 1),
      shape: BoxShape.rectangle,
    ),
    rangeEndDecoration: BoxDecoration(
      color: Color.fromRGBO(237, 195, 191, 1),
      shape: BoxShape.rectangle,
    ),
    withinRangeDecoration:
        BoxDecoration(color: Color.fromRGBO(237, 195, 191, 1)),
  );
  Map<String, CalendarStyle> styles = {
    "menstrual": CalendarStyle(
      rangeHighlightColor: Color.fromRGBO(237, 195, 191, 1),
      rangeStartDecoration: BoxDecoration(
        color: Color.fromRGBO(237, 195, 191, 1),
        shape: BoxShape.rectangle,
      ),
      rangeEndDecoration: BoxDecoration(
        color: Color.fromRGBO(237, 195, 191, 1),
        shape: BoxShape.rectangle,
      ),
      withinRangeDecoration:
          BoxDecoration(color: Color.fromRGBO(237, 195, 191, 1)),
    ),
    "follicular": CalendarStyle(
      rangeHighlightColor: Color.fromRGBO(213, 206, 229, 1),
      rangeStartDecoration: BoxDecoration(
        color: Color.fromRGBO(213, 206, 229, 1),
        shape: BoxShape.rectangle,
      ),
      rangeEndDecoration: BoxDecoration(
        color: Color.fromRGBO(213, 206, 229, 1),
        shape: BoxShape.rectangle,
      ),
      withinRangeDecoration:
          BoxDecoration(color: Color.fromRGBO(213, 206, 229, 1)),
    ),
    "ovulatory": CalendarStyle(
      rangeHighlightColor: Color.fromRGBO(204, 218, 214, 1),
      rangeStartDecoration: BoxDecoration(
        color: Color.fromRGBO(204, 218, 214, 1),
        shape: BoxShape.rectangle,
      ),
      rangeEndDecoration: BoxDecoration(
        color: Color.fromRGBO(204, 218, 214, 1),
        shape: BoxShape.rectangle,
      ),
      withinRangeDecoration:
          BoxDecoration(color: Color.fromRGBO(204, 218, 214, 1)),
    ),
    "luteal": CalendarStyle(
      rangeHighlightColor: Color.fromRGBO(241, 222, 204, 1),
      rangeStartDecoration: BoxDecoration(
        color: Color.fromRGBO(241, 222, 204, 1),
        shape: BoxShape.rectangle,
      ),
      rangeEndDecoration: BoxDecoration(
        color: Color.fromRGBO(
            241, 222, 204, 1), // Example: blue background for end of range
        shape: BoxShape.rectangle,
      ),
      withinRangeDecoration:
          BoxDecoration(color: Color.fromRGBO(241, 222, 204, 1)),
      // Add other properties like text styles, margins, etc., as needed
    ),
  };
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    dateTimeRanges = widget.initialDateTimeRanges ?? _defaultDateTimeRanges;
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  CustomDateTimeRange? dayInRange(DateTime day) {
    List<CustomDateTimeRange> list = dateTimeRanges
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

        rangeSelectionMode: rangeSelectionMode,

        // CalendarBuilders with null safety applied

        calendarBuilders: CalendarBuilders(
          prioritizedBuilder: (context, day, focusedMonth) {
            CustomDateTimeRange? dateTimeRange = dayInRange(day);

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
                            styles[dateTimeRange.phase]!.rangeHighlightScale,
                        color: styles[dateTimeRange.phase]!.rangeHighlightColor,
                      ),
                    );
                    children.add(rangeHighlight);
                  }

                  Widget? content;

                  if (isRangeStart) {
                    content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: styles[dateTimeRange.phase]!.cellMargin,
                      decoration:
                          styles[dateTimeRange.phase]!.rangeStartDecoration,
                      alignment: Alignment.center,
                      child: Text('${day.day}',
                          style:
                              styles[dateTimeRange.phase]!.rangeStartTextStyle),
                    );
                  } else if (isRangeEnd) {
                    content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: styles[dateTimeRange.phase]!.cellMargin,
                      decoration:
                          styles[dateTimeRange.phase]!.rangeEndDecoration,
                      alignment: Alignment.center,
                      child: Text('${day.day}',
                          style:
                              styles[dateTimeRange.phase]!.rangeEndTextStyle),
                    );
                  } else if (isWithinRange) {
                    content = AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      margin: styles[dateTimeRange.phase]!.cellMargin,
                      decoration:
                          styles[dateTimeRange.phase]!.withinRangeDecoration,
                      alignment: Alignment.center,
                      child: Text('${day.day}',
                          style: styles[dateTimeRange.phase]!
                              .withinRangeTextStyle),
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
          //print("onDaySelected ${focDay}");
          if (!isSameDay(_selectedDay, selDay)) {
            setState(() {
              _selectedDay = selDay;
              _focusedDay = focDay;

              rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          }
        },
        onRangeSelected: (start, end, focDay) {
          setState(() {
            _selectedDay = focDay;
            _focusedDay = focDay;

            bool startDateInRange = false;
            bool endDateInRange = false;

            print("start: ${start}");
            print("end: ${end}");
            print("focDay: ${focDay}");

            CustomDateTimeRange? range = dayInRange(start!);
            print("range: ${range}");

            DateTime endDate = range?.end ?? start;
            DateTime startDate = range?.start ?? start;
            print("startDate: ${startDate}");
            print("endDate: ${endDate}");

            if (range == null && endDate != null) {
              range = dayInRange(endDate);
              if (range != null) {
                endDateInRange = true;
              }
            } else if (range != null) {
              startDateInRange = true;
              if (endDate != null && dayInRange(endDate) != null) {
                endDateInRange = true;
              }
            }

            bool insertNewRange = true;

            if (startDateInRange) {
              if (isInRange(startDate, startDate, endDate)) {
                int index = dateTimeRanges.indexOf(range!);
                print("index: ${index}");

                if (!endDateInRange && endDate != null) {
                  dateTimeRanges[index] = CustomDateTimeRange(
                      start: startDate,
                      end: endDate,
                      phase: dateTimeRanges[index].phase);
                } else {
                  dateTimeRanges[index] = CustomDateTimeRange(
                      start: startDate,
                      end: endDate,
                      phase: dateTimeRanges[index].phase);
                }
                insertNewRange = false;
              }
            }

            if (endDateInRange) {
              if (isInRange(endDate, startDate, endDate)) {
                print("enddate is not null and is in range");
                int index = dateTimeRanges.indexOf(range!);
                print("second index: ${index}");
                dateTimeRanges[index] = CustomDateTimeRange(
                    start: startDate,
                    end: endDate,
                    phase: dateTimeRanges[index].phase);
                insertNewRange = false;
              }
            }

            if (insertNewRange) {
              dateTimeRanges
                  .add(CustomDateTimeRange(start: startDate, end: endDate));
              dateTimeRanges.add(CustomDateTimeRange(
                  start: startDate.subtract(Duration(days: 6)),
                  end: endDate.subtract(Duration(days: 6))));
              dateTimeRanges.add(CustomDateTimeRange(
                  start: startDate.add(Duration(days: 6)),
                  end: endDate.add(Duration(days: 6))));
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
