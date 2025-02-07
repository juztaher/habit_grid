// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../utils/constants.dart';

class SplashScreen extends StatelessWidget {
  static const String id = '/splash_screen';
  final AuthController authController = Get.find<AuthController>();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authController.checkUserStatus();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 120.0,
              height: 140.0,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  Color color = index == 2
                      ? kRedProgressColor
                      : (index < 8 ? kGreenProgressColor : kNoProgressColor);
                  return Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Obx(() => Text(
                  authController.displayMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                )),
            const SizedBox(height: 120),
            Obx(() => authController.showButton.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: authController.signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          side: const BorderSide(
                            color: Color(0xFFEEEEEE),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('images/google.png'),
                            height: 40.0,
                          ),
                          const SizedBox(width: 12.0),
                          const Text(
                            "SIGN UP WITH GOOGLE",
                            style: kSignUpButtonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox()),
          ],
        ),
      ),
    );
  }
}
