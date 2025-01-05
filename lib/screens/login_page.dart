import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_demo/utils/binding/binding.dart';
import 'package:todo_demo/utils/string_constants/string_constants.dart';
import 'package:todo_demo/utils/widgets/todo_appbar.dart';
import 'package:todo_demo/utils/widgets/todo_elevated_button.dart';
import 'package:todo_demo/utils/widgets/todo_sized_box.dart';
import 'package:todo_demo/utils/widgets/todo_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const TodoAppbar(title: StringConstants.login),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TodoTextFormField(
                controller: kLogincontroller.emailController,
                labelText: StringConstants.login,
                keyboardType: TextInputType.emailAddress),
            const TodoSizedBox(height: 10),
            TodoTextFormField(
              controller: kLogincontroller.passwordController,
              labelText: StringConstants.password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            const TodoSizedBox(height: 20),
            Obx(() => TodoElevatedButton(
                title: StringConstants.login,
                onPressed: kLogincontroller.isLoading.value
                    ? null
                    : () {
                        kLogincontroller.login();
                      },
                isLoading: kLogincontroller.isLoading.value)),
          ],
        ),
      ),
    );
  }
}
