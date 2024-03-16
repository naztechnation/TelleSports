import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:tellesports/core/app_export.dart';

class CalendarListView extends StatefulWidget {
  @override
  _CalendarListViewState createState() => _CalendarListViewState();
}

class _CalendarListViewState extends State<CalendarListView> {
  int _selectedDay = DateTime.now().day;

  final _scrollController = ScrollController();


@override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollDown();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int currentDay = now.day;
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return SizedBox(
      height: 65.adaptSize,
      child: ListView.builder(
        itemCount: currentDay,
                            controller: _scrollController,

        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final int adjustedIndex = index + 1;
          final DateTime date = DateTime(now.year, now.month, adjustedIndex);
          final bool isCurrentDay = adjustedIndex == currentDay;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedDay = adjustedIndex;

                
              });
            },
            child: Container(
              height: 65.adaptSize,
              width: 53.adaptSize,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isCurrentDay
                    ? (_selectedDay == adjustedIndex ? Colors.green.shade900 : Colors.green.shade900)
                    : (_selectedDay == adjustedIndex ? Colors.grey : Colors.white),
                border: Border.all(color: Colors.green.shade900),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontWeight: isCurrentDay ? FontWeight.bold : FontWeight.normal,
                      color: isCurrentDay
                          ? (_selectedDay == adjustedIndex ? Colors.white : Colors.white)
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      color: isCurrentDay
                          ? (_selectedDay == adjustedIndex ? Colors.white : Colors.white)
                          : Colors.black,
                      fontWeight: isCurrentDay ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

   void _scrollDown() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
}
