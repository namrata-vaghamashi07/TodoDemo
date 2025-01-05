import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_demo/screens/todo_list_page.dart';
import 'package:todo_demo/utils/string_constants/string_constants.dart';

class LoginController extends GetxController {
  // TextEditingController for email and password input fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Reactive loading state
  RxBool isLoading = false.obs;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login method
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(StringConstants.error, StringConstants.passwordMsg);
      return;
    }

    isLoading.value = true;

    try {
      // Sign in the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection(StringConstants.user)
          .doc(userCredential.user?.uid)
          .get();

      if (userDoc.exists) {
        Get.snackbar(StringConstants.success, StringConstants.loginSuccessMsg);
        Get.off(const TodoListPage());
      } else {
        await _firestore
            .collection(StringConstants.user)
            .doc(userCredential.user?.uid)
            .set({
          StringConstants.emailText: email,
          StringConstants.lastLogin: FieldValue.serverTimestamp(),
        });
        Get.snackbar(StringConstants.success, StringConstants.newUserStroeMsg);
        Get.off(const TodoListPage());
      }
    } catch (e) {
      Get.snackbar(StringConstants.error,
          '${StringConstants.loginFailedMsg} ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
