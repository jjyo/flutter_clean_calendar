import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';
import "package:intl/intl.dart";

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List events;
  final TextStyle dayOfWeekStyle;
  final TextStyle dateStyles;
  final Widget child;
  final Color selectedColor;
  final Color todayColor;
  final Color eventColor;
  final Color eventDoneColor;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.inMonth: true,
    this.events,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            dayOfWeek,
            style: dayOfWeekStyle,
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: onDateSelected,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedColor != null
                        ? Utils.isSameDay(this.date, DateTime.now())
                            ? Colors.red
                            : selectedColor
                        : Theme.of(context).primaryColor,
                  )
                : BoxDecoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                Text(
                  DateFormat("d").format(date),
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : Utils.isSameDay(this.date, DateTime.now())
                              ? todayColor
                              : inMonth ? Colors.black87 : Colors.grey),
                ),
                events != null && events.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events.map((event) {
                          eventCount++;
                          if (eventCount > 3) return Container();


                          Color dotColor = event["isDone"]
                              ? eventDoneColor ??
                              Theme.of(context).primaryColor
                              : eventColor ?? Theme.of(context).accentColor;

                          if (isSelected){
                            dotColor = Colors.white;
                          }

                          return Container(
                            margin: EdgeInsets.only(
                                left: 2.0, right: 2.0),
                            width: 4.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: dotColor,
                            ),
                          );
                        }).toList())
                    : SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
