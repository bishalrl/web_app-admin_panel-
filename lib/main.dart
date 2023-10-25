import 'package:ecommerce/screens/layout_screen.dart';
import 'package:ecommerce/screens/web_screen/add_product.dart';
import 'package:ecommerce/screens/web_screen/dashboardscreen.dart';
import 'package:ecommerce/screens/web_screen/delete_screen.dart';
import 'package:ecommerce/screens/web_screen/update_screen.dart';
import 'package:ecommerce/screens/web_screen/web_login.dart';
import 'package:ecommerce/screens/web_screen/web_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp();
  }

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const
            // Web_Main(),
            Layout_Screen(),
        routes: {
          Add_Product_Screen.id: (context) => const Add_Product_Screen(),
          Web_Main.id: (context) => const Web_Main(),
          WebLogin.id: (context) => const WebLogin(),
          Update_Product_Screen.id: (context) => const Update_Product_Screen(),
          Delete_Product_Screen.id: (context) => const Delete_Product_Screen(),
          DashBoard.id: (context) => const DashBoard()
        },
      );
    });
  }
}
