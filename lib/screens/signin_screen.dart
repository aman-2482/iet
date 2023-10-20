import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iet_app/screens/home_screen.dart';
import 'package:iet_app/screens/signup_screen.dart';
import 'package:iet_app/utils/color_utils.dart';

import '../reusable_widgets/reusable_widget.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/Final-Logo.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField(
                  "Enter User Name",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  false,
                  _passwordTextController,
                ),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString}");
                        
                  });


                }),
                signUpOption(context), // Pass the context
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoWidget(String imagePath) {
    return Image.asset(
      imagePath,
      width: 200,
      height: 200,
    );
  }

  Row signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70)),
        MouseRegion(
          onEnter: (event) {
            setState(() {
              isHovering = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovering = false;
            });
          },
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: isHovering
                    ? Colors.blue
                    : Colors.white, // Change text color on hover
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
