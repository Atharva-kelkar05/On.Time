import 'package:flutter/material.dart';
import 'package:on_time/styles/common_styles.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:table_calendar/table_calendar.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  //DateTime _selectedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, String> _notes = {}; // Step 2: Implement Note Functionality

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonStyles.backgroundGradient.colors[0],
      appBar: AppBar(
        backgroundColor: CommonStyles.backgroundGradient.colors[0],
        title: const Text(
          'on.time',
          style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat'),
        ),
        elevation: 3.0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              print('notifications clicked');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: Colors.white,
            onPressed: () {
              print('more clicked');
            },
          )
        ],
      ),
      body: Container(
        decoration:
            const BoxDecoration(gradient: CommonStyles.backgroundGradient),
        height: MediaQuery.of(context).size.height * 0.99,
        width: MediaQuery.of(context).size.width * 0.99,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              "Let's be on.time!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Open Sans',
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Center(
            child: CustomSlidingSegmentedControl<int>(
              fixedWidth: 120,
              thumbDecoration: BoxDecoration(
                  color: CommonStyles.backgroundGradient.colors[2],
                  borderRadius: BorderRadius.circular(5)),
              onTapSegment: (segment) {
                print('Segment $segment selected');
                return true;
              },
              innerPadding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: const Color(0xFF3C1F7B),
                borderRadius: BorderRadius.circular(10),
              ),
              initialValue: 0,
              children: const {
                0: Text('Schedule',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Open Sans')),
                1: Text(
                  'Note',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Open Sans'),
                ),
              },
              onValueChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Expanded(
            child: _selectedIndex == 0
                ? _buildScheduleContent()
                : _buildNoteContent(),
          ),
        ]),
      ),
    );
  }

  Widget _buildScheduleContent() {
    return Center(
      child: Column(
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2028, 12, 31),
            daysOfWeekStyle: const DaysOfWeekStyle(
              decoration: BoxDecoration(
                color: Colors.transparent,
              // backgroundBlendMode: BlendMode.difference,
            ),
            weekdayStyle: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
            weekendStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
            ),
            focusedDay: _focusedDay,
            //customizing the header for the calendar.
            headerStyle: const HeaderStyle(
              titleCentered: true,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              formatButtonVisible: false,

            ),
            calendarFormat: CalendarFormat.month,
            //Marking the selected day with a circle and changing the color of the selected day.
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },

            //Declaring the starting day of the week.
            startingDayOfWeek: StartingDayOfWeek.sunday,
            //customizing calendar style with CalendarStyle class.
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Colors.white, // Selected day color
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,),
              todayDecoration: const BoxDecoration(
                color: Color(0xFF7E64FF), // Today's color
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              outsideTextStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (day.weekday == DateTime.sunday || day.weekday == DateTime.saturday) {
                  return Center(
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(
                          color: Color(0xFFFF636C),
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          // Display and edit notes for the selected day
          if (_notes.containsKey(_selectedDay))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Note: ${_notes[_selectedDay]}",
                softWrap: true,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  _notes[_selectedDay!] = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter note for the day!',
                  hintStyle: const TextStyle(color: Colors.black87),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.only(left: 12.0, right: 12.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0))),
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note, size: 100, color: Colors.white),
          Text('Note content goes here',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Open Sans')),
        ],
      ),
    );
  }
}
