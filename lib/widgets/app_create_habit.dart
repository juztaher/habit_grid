// create_habit_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_grid/controllers/habit_controller.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';

class CreateHabitWidget extends StatelessWidget {
  final HabitController controller = Get.find<HabitController>();

  CreateHabitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "CREATE HABIT",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Obx(
                          // Obx for Icon Dropdown
                          () => DropdownButton<IconData>(
                            value: controller.selectedIcon.value,
                            underline: Container(),
                            items: habitIconsList
                                .map((icon) => DropdownMenuItem(
                                      value: icon,
                                      child: Icon(icon, size: 30),
                                    ))
                                .toList(),
                            onChanged: (icon) {
                              controller.selectedIcon.value = icon!;
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Enter Habit",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onChanged: (value) =>
                                controller.habitName.value = value,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Obx(
                      // Obx for Start Date
                      () => ListTile(
                        leading: const Icon(Icons.calendar_today,
                            color: Colors.blue),
                        title: Text(
                          controller.startDate.value == null
                              ? "Start Date: Click to Select"
                              : "Start Date: ${DateFormat('dd-MM-yyyy').format(controller.startDate.value!)}",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20),
                        ),
                        onTap: () => controller.pickDate(context, true),
                      ),
                    ),
                    Obx(
                      // Obx for End Date
                      () => ListTile(
                        leading: const Icon(Icons.calendar_today,
                            color: Colors.blue),
                        title: Text(
                          controller.endDate.value == null
                              ? "End Date: Click to Select"
                              : "End Date: ${DateFormat('dd-MM-yyyy').format(controller.endDate.value!)}",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20),
                        ),
                        onTap: () => controller.pickDate(context, false),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  controller.processHabit();
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  color: Colors.black,
                  child: Center(
                      child: Text(
                    "CREATE",
                    style: kBottomNavHeaderTextStyle,
                  )),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: -60,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => Get.back(),
            backgroundColor: Colors.white,
            elevation: 4,
            mini: true,
            shape: const CircleBorder(),
            child: const Icon(Icons.close, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
