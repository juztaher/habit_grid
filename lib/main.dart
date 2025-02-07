import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_grid/services/connectivity_service.dart';
import 'controllers/habit_controller.dart';
import 'screens/dashboard_screen.dart';
import 'screens/splash_screen.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(HabitController());
  Get.put<ConnectivityService>(ConnectivityService()); // Initialize the service
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HABIT GRID',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      getPages: [
        GetPage(name: SplashScreen.id, page: () => SplashScreen()),
        GetPage(name: DashboardScreen.id, page: () => DashboardScreen()),
      ],
    );
  }
}
