import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plumber_manager/view-model/kaamgarprovider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class KaamGarDetailsScreen extends StatefulWidget {
  final String kaamGar;
  const KaamGarDetailsScreen({super.key, required this.kaamGar});

  @override
  _KaamGarDetailsScreenState createState() => _KaamGarDetailsScreenState();
}

class _KaamGarDetailsScreenState extends State<KaamGarDetailsScreen> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final kaamGarProvider = Provider.of<KaamGarProvider>(context);
    final Box kaamGarBox = Hive.box("KaamGarBox");
    final List<dynamic>? workHistory = kaamGarBox.get(widget.kaamGar);
    
    print("Selected KaamGar Is : ${widget.kaamGar} And Its Associated Values Are : $workHistory");
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kaamGar, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                _showAttendanceDialog(context, selectedDay);
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: TextStyle(color: Colors.black),
                weekendTextStyle: TextStyle(color: Colors.red),
                markerDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, date, _) {
                  bool isPresent = workHistory?.any((workItem) =>
                          workItem[1] == date.toIso8601String()) ??
                      false;
                  return Container(
                    margin: EdgeInsets.all(4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isPresent ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${date.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAttendanceDialog(BuildContext context, DateTime date) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('कामगार नाव: ${widget.kaamGar}'),
          content: Text('कामावर हजर होते काय?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('नाही'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showLocationDialog(context, date);
              },
              child: Text('होय'),
            ),
          ],
        );
      },
    );
  }

  void _showLocationDialog(BuildContext context, DateTime date) {
    TextEditingController locationController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('कामाची जागा टाका:'),
          content: TextField(
            controller: locationController,
            decoration: InputDecoration(hintText: 'ठिकाण प्रविष्ट करा'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('रद्द करा'),
            ),
            TextButton(
              onPressed: () {
                print("Hi ${widget.kaamGar}");
                Provider.of<KaamGarProvider>(context, listen: false)
                    .markAttendance(context,widget.kaamGar, date,
                        locationController.text??"No Location");
                Navigator.pop(context);
              },
              child: Text('सबमिट'),
            ),
          ],
        );
      },
    );
  }
}