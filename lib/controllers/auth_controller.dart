// auth_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../screens/splash_screen.dart';
import '../services/google_auth_service.dart';
import '../screens/dashboard_screen.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var isLoggedIn = false.obs;
  var displayMessage = "HABIT GRID".obs;
  var showButton = false.obs;

  void checkUserStatus() async {
    isLoggedIn.value = await AuthService.instance.isUserLoggedIn();
    if (isLoggedIn.value) {
      Get.offNamed(DashboardScreen.id);
    } else {
      displayMessage.value = "VISUALIZE YOUR \n LIFE PROGRESS";
      showButton.value = true;
    }
  }

  Future<void> signInWithGoogle() async {
    final user = await AuthService.instance.signUp();

    if (user != null) {
      DocumentSnapshot userDoc =
          await _fireStore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        await _fireStore.collection('users').doc(user.uid).set({
          'email': user.email,
          'name': user.displayName,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Get.snackbar('Success', 'User Created successfully');

      isLoggedIn.value = true;
      Get.offNamed(DashboardScreen.id);
    }
  }

  Future<void> logout() async {
    await AuthService.instance.signOut();
    Get.offAllNamed(SplashScreen.id);
  }
}
