import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';

import '../../widgets/glitch.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController =  TextEditingController();
  final TextEditingController _passwordController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlithEffect(
              child: const Text(
                'TikTok Clone',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputFiled(
                  controller: _emailController,
                  myIcon: Icons.email,
                  mylabelText: "Enter your Email",
                  toHide: false),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputFiled(
                  controller: _passwordController,
                  myIcon: Icons.lock,
                  mylabelText: "Enter your Password",
                  toHide: true),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () {
                    AuthController.instance
                        .login(_emailController.text, _passwordController.text);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text('Login'),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                  onPressed: () {
                   Get.offAll(SignUpScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text('SignUp'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
