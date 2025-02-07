import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/habit_model.dart';

class HabitController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxList<Habit> habits = <Habit>[].obs;
  late String _currentUserId;

  var selectedIcon = Icons.fitness_center.obs;
  var habitName = "".obs;
  var habitId = "".obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var habitRecords = RxMap<DateTime, bool>();

  @override
  void onInit() {
    super.onInit();
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _currentUserId = user.uid;
      fetchHabits();
    } else {
      print("User not logged in!");
      Get.snackbar("Error", "User not logged in. Please sign in.");
    }
  }

  Future<void> fetchHabits() async {
    try {
      QuerySnapshot snapshot = await _fireStore
          .collection('users')
          .doc(_currentUserId)
          .collection('habits')
          .get();

      habits.value = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Habit.fromMap(data); // Use fromMap to parse data
      }).toList();
    } catch (e) {
      print("Error fetching habits: $e");
      Get.snackbar("Error", "Failed to fetch habits. Please try again later.");
    }
  }

  Future<void> addHabit(Habit habit) async {
    try {
      String newHabitId = _fireStore
          .collection('users')
          .doc(_currentUserId)
          .collection('habits')
          .doc()
          .id;

      Habit habitWithId = Habit(
        hId: newHabitId,
        hName: habit.hName,
        hEmoji: habit.hEmoji,
        hDurationCount: habit.hDurationCount,
        hDuration: habit.hDuration,
        hRecords: habit.hRecords,
      );

      await _fireStore
          .collection('users')
          .doc(_currentUserId)
          .collection('habits')
          .doc(newHabitId)
          .set(habitWithId.toMap());

      habits.add(habitWithId);
      Get.snackbar("Success", "Habit added successfully!");
    } catch (e) {
      print("Error adding habit: $e");
      Get.snackbar("Error", "Failed to add habit. Please try again later.");
    }
  }

  Future<void> updateHabit(Habit habit) async {
    try {
      await _fireStore
          .collection('users')
          .doc(_currentUserId)
          .collection('habits')
          .doc(habit.hId)
          .update(habit.toMap());

      int index = habits.indexWhere((h) => h.hId == habit.hId);
      if (index != -1) {
        habits[index] = habit;
        habits.refresh(); // Important: Refresh the list after update
      }

      Get.snackbar("Success", "Habit updated successfully!");
    } catch (e) {
      print("Error updating habit: $e");
      Get.snackbar("Error", "Failed to update habit. Please try again later.");
    }
  }

  Future<void> deleteHabit(String habitId) async {
    try {
      await _fireStore
          .collection('users')
          .doc(_currentUserId)
          .collection('habits')
          .doc(habitId)
          .delete();

      habits.removeWhere((habit) => habit.hId == habitId);
      Get.snackbar("Success", "Habit deleted successfully!");
    } catch (e) {
      print("Error deleting habit: $e");
      Get.snackbar("Error", "Failed to delete habit. Please try again later.");
    }
  }

  Future<void> clearAllHabits() async {
    try {
      QuerySnapshot snapshot = await _fireStore
          .collection('users')
          .doc(_currentUserId)
          .collection('habits')
          .get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      habits.clear(); // Clear the local list

      Get.snackbar("Success", "All habits cleared successfully!");
    } catch (e) {
      Get.snackbar(
          "Error", "Failed to clear all habits. Please try again later.");
    }
  }

  void pickDate(BuildContext context, bool isStartDate) async {
    DateTime today = DateTime.now();

    DateTime? initialDate =
        isStartDate ? today : startDate.value?.add(Duration(days: 1));

    DateTime? firstDate =
        isStartDate ? today : startDate.value?.add(Duration(days: 1));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      // initialDate: initialDate ?? today,
      // firstDate: firstDate ?? today,
      initialDate: DateTime(2000),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (isStartDate) {
        startDate.value = DateTime(
            pickedDate.year, pickedDate.month, pickedDate.day); // Only date
      } else {
        endDate.value = DateTime(
            pickedDate.year, pickedDate.month, pickedDate.day); // Only date
      }
    }
  }

  void pickEditDate(BuildContext context, bool isStartDate) async {
    DateTime oldStartDate = startDate.value!;
    DateTime oldEndDate = endDate.value!;

    DateTime initialDate = isStartDate ? oldStartDate : oldEndDate;
    DateTime firstDate = isStartDate ? DateTime(2000) : oldEndDate;
    DateTime lastDate = isStartDate ? oldStartDate : DateTime(2100);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      if (isStartDate) {
        if (pickedDate.isBefore(oldStartDate) ||
            pickedDate.isAtSameMomentAs(oldStartDate)) {
          startDate.value = pickedDate;
        } else {
          Get.snackbar(
              "Invalid Date", "Start date cannot be after the old start date.");
        }
      } else {
        if (pickedDate.isAfter(oldEndDate) ||
            pickedDate.isAtSameMomentAs(oldEndDate)) {
          endDate.value = pickedDate;
        } else {
          Get.snackbar(
              "Invalid Date", "End date cannot be before the old end date.");
        }
      }
    }
  }

  int getCurrentStreak(Habit habit) {
    List<DateTime> dates = habit.hRecords.keys.toList()..sort();
    DateTime today = DateTime.now();

    int streak = 0;

    for (int i = dates.length - 1; i >= 0; i--) {
      if (dates[i].isAfter(today)) continue;

      if (habit.hRecords[dates[i]] == true) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  int calculateDays() {
    var hDuration = 0;
    if (startDate.value != null && endDate.value != null) {
      if (endDate.value!.isBefore(startDate.value!)) {
        return 0;
      }
      hDuration = endDate.value!.difference(startDate.value!).inDays + 1;
    } else {
      hDuration = 0;
    }

    return hDuration;
  }

  void processHabit() {
    final hDurationCount = calculateDays();

    Map<DateTime, bool> habitRecords = {};
    for (DateTime date = startDate.value!;
        date.isBefore(endDate.value!.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      habitRecords[date] = false;
    }

    Habit newHabit = Habit(
      hId: '',
      hName: habitName.value,
      hEmoji: selectedIcon.value.codePoint.toString(),
      hDurationCount: hDurationCount,
      hDuration: [startDate.value!, endDate.value!],
      hRecords: habitRecords,
    );

    addHabit(newHabit);

    clearHabitSelection();
  }

  void clearHabitSelection() {
    selectedIcon.value = Icons.fitness_center;
    habitName.value = "";
    habitId.value = "";
    startDate.value = null;
    endDate.value = null;
  }
}
