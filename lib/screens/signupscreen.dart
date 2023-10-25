import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/styles.dart';
import 'package:ecommerce/widgets/ecobutton.dart';
import 'package:ecommerce/widgets/ecotextfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _repasswordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _repasswordcontroller.dispose();
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
      final accountstatus = await FirebaseServices.createAccount(
        _emailcontroller.text.toString(),
        _passwordcontroller.text.toString(),
      );

      if (accountstatus == null) {
        // Registration was successful
        // Navigate to another screen, e.g., LoginScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        // Show an error dialog when registration fails
        ecodialogue(accountstatus);
      }
    }
  }

  // else {
  //   // Show an error dialog when passwords don't match
  //   ecodialogue('Passwords do not match.');
  // }

  //  Navigator.push(
  //     context, MaterialPageRoute(builder: (_) => LoginScreen())));

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
                "Welcome\n Create Your Account",
                textAlign: TextAlign.center,
                style: EcoStyle.boldstyle,
              ),
              const SizedBox(
                height: 150,
              ),
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      EcoTextField(
                        validator: (v) {
                          if (v!.isEmpty ||
                              !v.contains('@') ||
                              !v.contains('.com')) {
                            return "email is badly formated";
                          }
                          return null;
                        },
                        hinttext: 'Email',
                        controller: _emailcontroller,
                        icon: const Icon(Icons.email),
                      ),
                      EcoTextField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "password should not be empty";
                          }
                          return null;
                        },
                        icon: const Icon(Icons.visibility),
                        hinttext: 'Password',
                        ispassword: true,
                        controller: _passwordcontroller,
                      ),
                      EcoTextField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "password should not be empty";
                            }
                            return null;
                          },
                          icon: const Icon(Icons.visibility),
                          hinttext: 'Re-Type Password',
                          ispassword: true,
                          controller: _repasswordcontroller),
                      const SizedBox(
                        height: 70,
                      ),
                      EcoButton(
                        buttonName: 'Signup',
                        isLogInButton: true,
                        onTap: () {
                          submit();
                        },
                      ),
                    ],
                  )),
              EcoButton(
                onTap: () {
                  Navigator.pop(context);
                },
                buttonName: 'back to LogIn',
                isLogInButton: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
