import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_grid/utils/constants.dart';
import 'package:intl/intl.dart';
import '../controllers/habit_controller.dart';
import '../models/habit_model.dart';

class EditHabitWidget extends StatelessWidget {
  final HabitController controller = Get.find<HabitController>();
  late DateTime oldStartDate;
  late DateTime oldEndDate;

  EditHabitWidget({
    super.key,
  }) {
    oldStartDate = controller.startDate.value!;
    oldEndDate = controller.endDate.value!;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "EDIT HABIT",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 40),
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
                                labelText: "Edit Habit",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              controller: TextEditingController(
                                  text: controller.habitName.value),
                              onChanged: (value) => {
                                    controller.habitName.value = value,
                                  }),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
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
                        onTap: () => controller.pickEditDate(context, true),
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
                        onTap: () => controller.pickEditDate(context, false),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      controller.deleteHabit(controller.habitId.value);
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        "DELETE",
                        style: kEditHabitTextStyle,
                      )),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      DateTime newStartDate = controller.startDate.value!;
                      DateTime newEndDate = controller.endDate.value!;
                      Map<DateTime, bool> oldRecords =
                          Map.from(controller.habitRecords);

                      for (DateTime date = newStartDate;
                          date.isBefore(oldStartDate);
                          date = date.add(Duration(days: 1))) {
                        if (!oldRecords.containsKey(date)) {
                          oldRecords[date] = false;
                        }
                      }

                      for (DateTime date = oldEndDate.add(Duration(days: 1));
                          date.isBefore(newEndDate.add(Duration(days: 1)));
                          date = date.add(Duration(days: 1))) {
                        if (!oldRecords.containsKey(date)) {
                          oldRecords[date] = false;
                        }
                      }

                      Habit editedHabit = Habit(
                        hId: controller.habitId.value,
                        hName: controller.habitName.value,
                        hEmoji:
                            controller.selectedIcon.value.codePoint.toString(),
                        hDurationCount: controller.calculateDays(),
                        hDuration: [
                          controller.startDate.value!,
                          controller.endDate.value!
                        ],
                        hRecords: oldRecords,
                      );

                      controller.updateHabit(editedHabit);
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        "SAVE",
                        style: kEditHabitTextStyle,
                      )),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -60,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {},
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
