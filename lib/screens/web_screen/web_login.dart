// import 'package:ecommerce/screens/login_screen.dart';
// import 'package:ecommerce/screens/web_screen/web_main.dart';
// import 'package:ecommerce/utils/styles.dart';
// import 'package:ecommerce/widgets/ecobutton.dart';
// import 'package:ecommerce/widgets/ecotextfield.dart';
// import 'package:flutter/material.dart';

// class WebLogin extends StatelessWidget {
//   WebLogin({super.key});
//   final formkey = GlobalKey<FormState>();
//   final TextEditingController emailcontroller = TextEditingController();
//   final TextEditingController passwordcontroller = TextEditingController();
//   String email = "admin@gmail.com";
//   String password = "admin123";
// //function
//   submit(BuildContext context) {
//     if (formkey.currentState!.validate()) {
//       if (emailcontroller.text == email &&
//           passwordcontroller.text == password) {
//         Navigator.push(context, MaterialPageRoute(builder: (_) => Web_Main()));
//       }
//       ;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.black, width: 5),
//               borderRadius: BorderRadius.circular(15)),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "Wlcome Admin",
//                   style: EcoStyle.boldstyle,
//                 ),
//                 Text(
//                   "Login to your account",
//                   style: EcoStyle.boldstyle,
//                 ),
//                 EcoTextField(
//                     hinttext: 'Email',
//                     controller: emailcontroller,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "email is empty";
//                       }
//                       return 'nell saftey';
//                     }),
//                 EcoTextField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "PASSWORD is empty";
//                       }
//                       return "something is null";
//                     },
//                     hinttext: 'Password',
//                     controller: passwordcontroller),
//                 EcoButton(
//                   buttonName: 'Log In',
//                   onTap: () {
//                     MaterialButton(
//                       onPressed: () {
//                         if (email == emailcontroller &&
//                             password == passwordcontroller) {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (_) => Web_Main()));
//                         }
//                       },
//                       child: Text('Log in'),
//                     );
//                   },
//                   isLogInButton: true,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:ecommerce/screens/web_screen/web_main.dart';
import 'package:ecommerce/services/firebase_services.dart';
import 'package:ecommerce/utils/styles.dart';
import 'package:ecommerce/widgets/ecobutton.dart';
import 'package:ecommerce/widgets/ecodialogue.dart';
import 'package:ecommerce/widgets/ecotextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WebLogin extends StatefulWidget {
  static const String id = 'web_Login';

  const WebLogin({super.key});

  @override
  State<WebLogin> createState() => _WebLoginState();
}

class _WebLoginState extends State<WebLogin> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController usernamecontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  // Function to handle login
  void submit(context) async {
    if (formkey.currentState!.validate()) {
      try {
        final value =
            await FirebaseServices.adminSignIn(usernamecontroller.text.trim());
        if (value.exists) {
          final data = value.data() as Map<String, dynamic>;
          if (data['username'] == usernamecontroller.text &&
              data['password'] == passwordcontroller.text) {
            final user = await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Web_Main()));
            } else {
              showDialog(
                context: context,
                builder: (_) {
                  return const EcoDialogue(title: 'Failed to sign in.');
                },
              );
            }
          } else {
            showDialog(
              context: context,
              builder: (_) {
                return const EcoDialogue(title: 'Invalid username or password.');
              },
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (_) {
              return const EcoDialogue(title: 'Admin document not found.');
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) {
            return EcoDialogue(title: '$e');
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome Admin",
                    style: EcoStyle.boldstyle,
                  ),
                  const Text(
                    "Login to your account",
                    style: EcoStyle.boldstyle,
                  ),
                  EcoTextField(
                    hinttext: 'User Name',
                    controller: usernamecontroller,
                    // Example: Trim the input before validation
                    validator: (value) {
                      final trimmedValue = value?.trim();
                      if (trimmedValue == null || trimmedValue.isEmpty) {
                        return "User Name is empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    ispassword: true,
                    // Example: Trim the input before validation
                    validator: (value) {
                      final trimmedValue = value?.trim();
                      if (trimmedValue == null || trimmedValue.isEmpty) {
                        return "password is empty";
                      }
                      return null;
                    },

                    hinttext: 'Password',
                    controller: passwordcontroller,
                  ),
                  EcoButton(
                    buttonName: 'Log In',
                    onTap: () {
                      submit(context);

                      // Call the submit function directly
                    },
                    isLogInButton: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
