import 'package:flutter/material.dart';
import 'package:habit_grid/utils/constants.dart';
import '../models/habit_model.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final int streak;
  final VoidCallback onMarkHabit;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onMarkHabit,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime normalizedDate = DateTime(today.year, today.month, today.day);
    bool isMarked = habit.hRecords[normalizedDate] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    IconData(int.parse(habit.hEmoji),
                        fontFamily: 'MaterialIcons'),
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    habit.hName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onMarkHabit,
                    child: Visibility(
                      visible: !isMarked,
                      child: SizedBox(
                        height: 45,
                        width: 45,
                        child: Image.asset('images/mark_habit_icon.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Current Streak: $streak',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 1.1,
                ),
                itemCount: habit.hDurationCount,
                itemBuilder: (context, index) {
                  List<DateTime> dates = habit.hRecords.keys.toList()..sort();
                  DateTime blockDate = dates[index];
                  DateTime today = DateTime.now();
                  DateTime normalizedDate =
                      DateTime(today.year, today.month, today.day);

                  bool isToday = blockDate.year == today.year &&
                      blockDate.month == today.month &&
                      blockDate.day == today.day;

                  Color boxColor;

                  if (blockDate.isBefore(today) && !isToday) {
                    boxColor = habit.hRecords[blockDate] == true
                        ? kGreenProgressColor
                        : kRedProgressColor;
                  } else if (blockDate.isAtSameMomentAs(normalizedDate)) {
                    boxColor = habit.hRecords[blockDate] == true
                        ? kGreenProgressColor
                        : kNoProgressColor;
                  } else {
                    boxColor = kNoProgressColor;
                  }

                  return Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius: BorderRadius.circular(6),
                      border: isToday
                          ? Border.all(color: Colors.black, width: 2)
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
