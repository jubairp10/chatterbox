// import 'package:chatterbox/auth/auth_serviece.dart';
// import 'package:chatterbox/pages/home_page.dart';
// import 'package:chatterbox/pages/register_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
//
// class Login extends StatefulWidget {
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   String? email;
//   String? password;
//   bool showpass = true;
//
//   var formkey = GlobalKey<FormState>();
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void showSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     ScreenUtil.init(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       body: Form(
//         key: formkey,
//         child: ListView(
//           children: [
//             SizedBox(height: 40.h),
//             Center(
//               child: Text(
//                 "Hello Again!",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30.sp),
//               ),
//             ),
//             SizedBox(height: 10.h),
//             Text(
//               textAlign: TextAlign.center,
//               "Welcome Back You’ve\nbeen Missed!",
//               style: TextStyle(color: Colors.black),
//             ),
//             SizedBox(height: 38.h),
//             Padding(
//               padding: const EdgeInsets.only(left: 26, right: 26),
//               child: Container(
//                 height: 60.h,
//                 width: 377.w,
//                 child: TextFormField(
//                   controller: emailController,
//                   textInputAction: TextInputAction.next,
//                   style: TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     hintText: "Enter email",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                   onSaved: (eemail) {
//                     email = eemail;
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.h),
//             RPadding(
//               padding: const EdgeInsets.only(left: 26, right: 26),
//               child: Container(
//                 height: 60.h,
//                 width: 377.w,
//                 child: TextFormField(
//                   controller: passwordController,
//                   textInputAction: TextInputAction.next,
//                   style: TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     hintText: " Password",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide(color: Colors.white)),
//                   ),
//                   validator: (password) {
//                     if (password!.isEmpty || password.length < 8) {
//                       return "Password eg Adacode@123";
//                     } else {
//                       return null;
//                     }
//                   },
//                   onSaved: (epass) {
//                     password = epass;
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 30.h),
//             RPadding(
//               padding: const EdgeInsets.only(right: 25, left: 25),
//               child: InkWell(
//                 onTap: () async {
//                   if (formkey.currentState!.validate()) {
//                     User? user = await FirebaseHelper().signIn(
//                       emailController.text,
//                       passwordController.text,
//                     );
//                     if (user != null) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomePage()),
//                       );
//                     } else {
//                       showSnackbar('Login failed. Please check your credentials.');
//                     }
//                   }else{
//
//                     showSnackbar("User already exists with this email");
//                   }
//                 },
//                 child: Container(
//                   height: 50.h,
//                   margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
//                   decoration: BoxDecoration(
//                     color: Colors.teal,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                       child: Text(
//                         "Login",
//                         style: TextStyle(color: Colors.white, fontSize: 20.sp),
//                       )),
//                 ),
//               ),
//             ),
//             SizedBox(height: 26.h),
//             Center(
//                 child: InkWell(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Regi()));
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Create a new Account ?",
//                           style: TextStyle(
//                             color: Colors.black87,
//                           ),
//                         ),
//                         Text(
//                           "SignUp ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black),
//                         )
//                       ],
//                     ))),
//             SizedBox(height: 30.h),
//             Center(child: Text("OR")),
//             SizedBox(height: 50.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: 7.w),
//                 InkWell(
//                   onTap: ()
//                   async {
//                     User? user = (await FirebaseHelper().signInWithGoogle()) as User?;
//                     if (user != null) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomePage()),
//                       );
//                     } else {
//                       showSnackbar('Google Sign-In failed. Please try again.');
//                     }
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     height: 40.h,
//                     decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       children: [
//                         Image(
//                           image: AssetImage("assets/image/google-logo-9808.png"),
//                         ),
//                         Text(
//                           "   Google   ",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 25.w,),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   height: 40.h,
//                   decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image(
//                         image: AssetImage("assets/image/pngwing.com.png"),
//                       ),
//                       Text(
//                         "   Apple  ",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';


import 'package:chatterbox/pages/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

import '../auth/auth_serviece.dart';
import '../compnents/constructs.dart';
import '../compnents/snackbar.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _obscurePassword = true;
  bool isLoading = false;
  Future<void> saveFcmToken(User user) async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();

    if (token != null) {
      log("FCM Token: $token");
      await _firestore.collection("users").doc(user.uid).set({
        "uid": user.uid,
        "email": user.email,
        "fcmToken": token,
      }, SetOptions(merge: true)); // Merges with existing document data
    }
  }

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String res = await AuthenticationService().signInUser(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (res == "success") {
        User? user = _auth.currentUser; // Get the current user
        if (user != null) {
          await saveFcmToken(user);
        }

        CustomSnackBar.show(
          context,
          snackBarType: SnackBarType.success,
          label: "User logged in successfully!",
          bgColor: Colors.green,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              currentUserEmail: _emailController.text,
            ),
          ),
        );
      } else {
        CustomSnackBar.show(
          context,
          snackBarType: SnackBarType.fail,
          label: "Login Failed",
          bgColor: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.message,size: 45,),
                      const SizedBox(height: 20),
                      const Text(
                        "Welcome Back!",
                        style: AppTypography.outfitboldmainHead,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Please login to your account",
                        style: AppTypography.outfitboldsubHead.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email TextField
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: AppTypography.outfitRegular
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password TextField
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: AppTypography.outfitRegular
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Login Button with loading indicator
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : loginUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF11002C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Create Account button
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not a member?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                                    (route) => false,
                              );
                            },
                            child: Text(
                              "Register Now",
                              style: AppTypography.outfitRegular.copyWith(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}