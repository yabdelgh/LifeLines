import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:LifeLines/components/card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TableBasicsExample extends StatefulWidget {

  final List<Map<String, dynamic>> notes;
  const TableBasicsExample({super.key, required this.notes});

  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

bool isTheSameDay(DateTime? dateTime1, Timestamp? b) {
    if (dateTime1 == null || b == null)
    {
      return false;
    }
    DateTime dateTime2 = b.toDate();
    // return a.day == b.toDate().day;
    return (dateTime1.year == dateTime2.year) &&
                  (dateTime1.month == dateTime2.month) &&
                  (dateTime1.day == dateTime2.day);
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TableCalendar(
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.white),
                weekendStyle: TextStyle(color: Colors.white),
              ),
              headerStyle:  HeaderStyle(
                titleTextStyle: const  TextStyle(color: Colors.white), 
                formatButtonTextStyle:
                    const TextStyle(color: Colors.white),
                formatButtonDecoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2,),
                  borderRadius: BorderRadius.circular(10)
                ), 
                leftChevronIcon: const Icon(Icons.chevron_left,
                    color: Colors.white),
                rightChevronIcon: const Icon(Icons.chevron_right,
                    color: Colors.white),
              ),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              calendarStyle: const CalendarStyle(
                defaultTextStyle: TextStyle(color: Colors.white),
              ),
            
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.
            
                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  debugPrint('------------------------------------------------');
                  // debugPrint(_selectedDay.toString());
                  debugPrint(selectedDay.toLocal().day.toString());
                 debugPrint(widget.notes.toString());
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
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
            const SizedBox(height: 30),
            Column(
                    children: [
                      Column(
                          children: widget.notes
                              .where((data) => isTheSameDay(_selectedDay, data['data']['createdAt']))
                              .map((data) => 
                                  CustomCard(id: data['id'], data: data['data']
                                ))
                              .toList()),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
