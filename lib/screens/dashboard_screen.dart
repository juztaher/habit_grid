import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_grid/models/habit_model.dart';
import 'package:habit_grid/utils/constants.dart';
import 'package:habit_grid/widgets/app_create_habit.dart';
import 'package:intl/intl.dart';
import '../controllers/auth_controller.dart';
import '../controllers/habit_controller.dart';
import '../widgets/app_edit_habit.dart';
import '../widgets/app_settings_menu.dart';
import '../widgets/habit_card.dart';

class DashboardScreen extends StatelessWidget {
  static const String id = '/dashboard_screen';
  final AuthController authController = Get.find<AuthController>();
  final HabitController habitController = Get.find<HabitController>();

  DashboardScreen({super.key});

  void _showAppSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppSettingsMenu(
          onClearAllData: () {
            Get.back();
            habitController.clearAllHabits();
          },
          onLogout: () {
            Get.back();
            authController.logout();
          },
        );
      },
    );
  }

  void _showCreateHabitCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreateHabitWidget();
      },
    ).then((result) {
      habitController.clearHabitSelection();
    });
  }

  void _showEditHabitCard(BuildContext context, Habit habit) {
    habitController.selectedIcon.value =
        IconData(int.parse(habit.hEmoji), fontFamily: 'MaterialIcons');
    habitController.habitName.value = habit.hName;
    habitController.startDate.value = habit.hDuration.first;
    habitController.endDate.value = habit.hDuration.last;
    habitController.habitId.value = habit.hId;
    habitController.habitRecords.value = habit.hRecords;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EditHabitWidget();
      },
    ).then((result) {
      habitController.clearHabitSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Obx(() {
                if (habitController.habits.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: habitController.habits.length,
                    itemBuilder: (context, index) {
                      final habit = habitController.habits[index];
                      final streakCount =
                          habitController.getCurrentStreak(habit);
                      return GestureDetector(
                        onTap: () {
                          _showEditHabitCard(context, habit);
                        },
                        child: HabitCard(
                          habit: habit,
                          streak: streakCount,
                          onMarkHabit: () {
                            DateTime today = DateTime.now();
                            DateTime normalizedDate =
                                DateTime(today.year, today.month, today.day);
                            habit.hRecords[normalizedDate] = true;
                            habitController.updateHabit(habit);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Text("No habits yet. Add one!");
                }
              }),
              SizedBox(
                height: 20,
              ),
            ],
          )),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: ImageIcon(AssetImage('images/create_habit_icon.png'),
                  color: Colors.white, size: 40),
              onPressed: () {
                _showCreateHabitCard(context);
              },
            ),
            Text(
              DateFormat('dd MMM').format(DateTime.now()),
              style: kBottomNavHeaderTextStyle,
            ),
            IconButton(
              icon: ImageIcon(AssetImage('images/app_settings_icon.png'),
                  color: Colors.white, size: 40),
              onPressed: () {
                _showAppSettings(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
