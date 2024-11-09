//
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'package:google_sign_in/google_sign_in.dart';
//
// class FirebaseHelper {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseFirestore _firestore=FirebaseFirestore.instance;
//
//
//
//
//
//   User get user => _auth.currentUser!; //
//
//   //State persistence
//   Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
//
//   // Sign In
//
//   Future<User?> signIn(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//
//       // Accessing the correct user data
//       _firestore.collection('Users').doc(result.user!.uid).set(
//         {
//           'uid': result.user!.uid,
//           'email': email,
//         },
//       );
//
//       return result.user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//
//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return null;
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//
//
//
//
//
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//
//
//   Future<String?> signUp({required String name, required String email, required String password, required BuildContext context}) async {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User? user = userCredential.user;
//       await user?.updateDisplayName(name);
//
//       _firestore.collection('Users').doc(userCredential.user!.uid).set(
//         {
//           'uid':userCredential.user!.uid,
//           'email':email,
//         }
//       );
//
//       return null;
//
//     } catch (e) {
//       print("Error during sign up: $e");
//       return e.toString();
//     }
//   }
//
// //already exist
//   Future<bool> checkIfUserExists(String email) async {
//     try {
//       final signInMethods = await _auth.fetchSignInMethodsForEmail(email);
//       return signInMethods.isNotEmpty;
//     } catch (e) {
//       print("Error checking user existence: $e");
//       return false;
//     }
//   }
//
//
//
//   // Sign Out
//   Future<void> signOut() async {
//
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//
//
//   }
//
//   // Get Current User
//   User? getCurrentUser() {
//     return _auth.currentUser;
//
//
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection("users").doc(credential.user!.uid).set({
        "uid": credential.user!.uid,
        "email": email,
      });

      return "Successfully";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("Error: Email already in use.");
        return "Email already in use";
      } else if (e.code == 'weak-password') {
        print("Error: Weak password.");
        return "Weak password";
      } else {
        print("Error: ${e.message}");
        return e.message ?? "Unknown error";
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return "An error occurred";
    }
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter your email and password";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }
}