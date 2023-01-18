import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/view/widgets/text_input.dart';

import '../../widgets/glitch.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _setpasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(
                child: const Text(
                  'Welcome To TikTok',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: (){
                  AuthController.instance.pickImage();
                },
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.pngitem.com/pimgs/m/421-4212341_default-avatar-svg-hd-png-download.png'),
                      //backgroundColor: Colors.deepPurple,
                      radius: 50,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 25,
                            color: Colors.black,
                          ),
                        ))
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),
              //Email Container
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
              //Password Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputFiled(
                    controller: _setpasswordController,
                    myIcon: Icons.lock,
                    mylabelText: "Enter your Password",
                    toHide: true),
              ),
              const SizedBox(
                height: 20,
              ),
              //Confirm Password Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputFiled(
                    controller: _confirmpasswordController,
                    myIcon: Icons.lock,
                    mylabelText: "Confirm your Password",
                    toHide: true),
              ),

              const SizedBox(
                height: 25,
              ),
              //User name Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputFiled(
                    controller: _userNameController,
                    myIcon: Icons.person,
                    mylabelText: "User Name",
                    toHide: false),
              ),
              const SizedBox(
                height: 30,
              ),
              //Button Container
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                    onPressed: () {
                      AuthController.instance.SignUp(
                          _userNameController.text,
                          _emailController.text,
                          _setpasswordController.text,
                          AuthController.instance.proImg);

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: const Text('Sign Up'),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
