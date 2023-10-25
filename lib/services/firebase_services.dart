// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseServices {
// static Future<DocumentSnapshot> adminSignIn(returntype) async {
//   var result = await FirebaseFirestore.instance
//       .collection('admin')
//       .doc(returntype)
//       .get();
//   return result;
// }

// Future<String?> createAccount(String email, String password) async {
//   // Your implementation here
// }

// Future<String?> signInAccount(String email, String password) async {
//   // Your implementation here
// }

//   static Future<String?> createAccount(String email, String password) async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return null; // Registration successful, return null for no error.
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
//         return "Email already in use.";
//       }
//       if (e.code == "ERROR_WEAK_PASSWORD") {
//         return "Weak password. Please use a stronger password.";
//       }
//       // Handle other FirebaseAuthException errors here if needed.
//       return e.message; // Return the error message for other exceptions.
//     } catch (e) {
//       return e.toString(); // Return the error message for unexpected errors.
//     }
//   }

//   //signIn
//   static Future<String?> signInAccount(String email, String password) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       return null; // Registration successful, return null for no error.
//     } on FirebaseAuthException catch (e) {
//       // Handle other FirebaseAuthException errors here if needed.
//       return e.message; // Return the error message for other exceptions.
//     } catch (e) {
//       return e.toString(); // Return the error message for unexpected errors.
//     }
//   }

// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static Future<DocumentSnapshot> adminSignIn(String returntype) async {
    var result = await FirebaseFirestore.instance
        .collection('admin')
        .doc(returntype)
        .get();
    return result;
  }

  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null; // Registration successful, return null for no error.
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email already in use.";
      }
      if (e.code == "weak-password") {
        return "Weak password. Please use a stronger password.";
      }
      // Handle other FirebaseAuthException errors here if needed.
      return e.message; // Return the error message for other exceptions.
    } catch (e) {
      return e.toString(); // Return the error message for unexpected errors.
    }
  }

  // signIn
  static Future<String?> signInAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null; // Registration successful, return null for no error.
    } on FirebaseAuthException catch (e) {
      // Handle other FirebaseAuthException errors here if needed.
      return e.message; // Return the error message for other exceptions.
    } catch (e) {
      return e.toString(); // Return the error message for unexpected errors.
    }
  }
}
