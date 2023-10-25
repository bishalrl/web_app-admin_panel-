import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/signupscreen.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/utils/styles.dart';
import 'package:ecommerce/widgets/ecobutton.dart';
import 'package:ecommerce/widgets/ecotextfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  Future<void> ecodialogue(String error) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                  buttonName: 'Close',
                  onTap: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      final accountstatus = await FirebaseServices.signInAccount(
        _emailcontroller.text.toString(),
        _passwordcontroller.text.toString(),
      );

      if (accountstatus == null) {
        // Registration was successful
        // Navigate to another screen, e.g., LoginScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        // Show an error dialog when registration fails
        ecodialogue(accountstatus);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 219, 219),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Welcome\n LogIn to Continue",
                textAlign: TextAlign.center,
                style: EcoStyle.boldstyle,
              ),
              const SizedBox(
                height: 200,
              ),
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      EcoTextField(
                        hinttext: 'Email',
                        controller: _emailcontroller,
                      ),
                      EcoTextField(
                        hinttext: 'Password',
                        ispassword: true,
                        controller: _passwordcontroller,
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      EcoButton(
                        onTap: () {
                          submit();
                        },
                        buttonName: 'Log In',
                        isLogInButton: true,
                      ),
                    ],
                  )),
              EcoButton(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpScreen()));
                },
                buttonName: 'Sign Up',
                isLogInButton: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
