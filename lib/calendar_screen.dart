import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'add_todo_screen.dart';
import 'bottom_nav_bar.dart';

class CalendarScreen extends StatefulWidget {
  final List<Map<String, dynamic>> notes;
  final List<Map<String, dynamic>> tasks;

  CalendarScreen({required this.notes, required this.tasks});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Map<String, dynamic>>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
  }

  void _loadEvents() {
    List<Map<String, dynamic>> allEvents = [...widget.notes, ...widget.tasks];

    for (var event in allEvents) {
      DateTime date = _parseDate(event['date']);
      if (_events[date] == null) {
        _events[date] = [];
      }
      _events[date]!.add(event);
    }
  }

  DateTime _parseDate(String dateString) {
    switch (dateString) {
      case 'Today':
        return DateTime.now();
      case 'Tomorrow':
        return DateTime.now().add(Duration(days: 1));
      case 'Yesterday':
        return DateTime.now().subtract(Duration(days: 1));
      default:
        return DateTime.parse(dateString);
    }
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _showMonthYearPicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        _focusedDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _showMonthYearPicker,
          child: Text(
            "${_getMonthName(_focusedDay.month)} ${_focusedDay.year}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            headerVisible: false,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              // Navigate to AddTodoScreen with the selected date as the due date
              Get.to(() => AddTodoScreen(initialDate: selectedDay));
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1, // Calendar is the second item in the navbar
        onItemTapped: (index) {
          if (index == 0) {
            Get.offAllNamed('/home'); // Navigate to HomeScreen
          } else if (index == 2) {
            Get.offAllNamed('/search'); // Navigate to SearchScreen
          } else if (index == 3) {
            Get.offAllNamed('/menu'); // Navigate to MenuScreen
          }
        },
        notes: widget.notes,
        tasks: widget.tasks,
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay!);

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return ListTile(
          title: Text(event['title']),
          subtitle: Text(event['content']),
          tileColor: event['color'],
        );
      },
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}