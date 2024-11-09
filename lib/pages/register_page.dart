// import 'package:chatterbox/auth/auth_serviece.dart';
// import 'package:chatterbox/pages/home_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
//
//
//
// class Regi extends StatefulWidget {
//   @override
//   State<Regi> createState() => _RegiState();
// }
//
// class _RegiState extends State<Regi> {
//   String? name1;
//   String? email;
//   String? password;
//   bool showpass = true;
//   var formkey = GlobalKey<FormState>();
//
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   TextEditingController namecontroller = TextEditingController();
//
//   void showSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   bool _isEmailValid(String email) {
//     final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//     return emailRegex.hasMatch(email);
//   }
//
//   Future<void> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//       if (userCredential.user != null) {
//         Get.to(HomePage());
//       }
//     } catch (e) {
//       showSnackbar("Error signing in with Google: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     ScreenUtil.init(context);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black87, size: 25.sp),
//         ),
//       ),
//       body: Form(
//         key: formkey,
//         child: ListView(
//           children: [
//             SizedBox(height: 40.h),
//             Center(
//               child: Text(
//                 "Hello Again!",
//                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.sp),
//               ),
//             ),
//             SizedBox(height: 10.h),
//             Text(
//               textAlign: TextAlign.center,
//               "Welcome Back You’ve\nbeen Missed!",
//               style: TextStyle(color: Colors.black),
//             ),
//             SizedBox(height: 40.h),
//             RPadding(
//               padding: const EdgeInsets.only(right: 26, left: 26),
//               child: Container(
//                 height: 67.h,
//                 width: 377.w,
//                 child: TextFormField(
//                   controller: namecontroller,
//                   textInputAction: TextInputAction.next,
//                   style: TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     hintText: "Enter name",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                   validator: (name) {
//                     if (name!.isEmpty) {
//                       return "Enter your name";
//                     } else {
//                       return null;
//                     }
//                   },
//                   onSaved: (ename) {
//                     name1 = ename;
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.h),
//             RPadding(
//               padding: const EdgeInsets.only(right: 26, left: 26),
//               child: Container(
//                 height: 67.h,
//                 width: 377.w,
//                 child: TextFormField(
//                   controller: emailcontroller,
//                   textInputAction: TextInputAction.next,
//                   style: TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     hintText: "Enter email",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     } else if (!_isEmailValid(value)) {
//                       return 'The email address is badly formatted';
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
//               padding: const EdgeInsets.only(right: 26, left: 26),
//               child: Container(
//                 height: 67.h,
//                 width: 377.w,
//                 child: TextFormField(
//                   controller: passwordcontroller,
//                   textInputAction: TextInputAction.next,
//                   style: TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[200],
//                     hintText: " Enter password",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                   validator: (password) {
//                     if (password!.isEmpty || password.length < 8) {
//                       return "Password must be at least 8 characters";
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
//                     formkey.currentState!.save();
//                     bool userExists = await context.read<FirebaseHelper>().checkIfUserExists(email!);
//                     if (!userExists) {
//                       await context.read<FirebaseHelper>().signUp(name: name1!, email: email!, password: password!, context: context).then((value) {
//                         if (value == null) {
//                           Get.to(HomePage());
//                         } else {
//                           Get.snackbar("Error", "User not found \nUser already exists with this email");
//                         }
//                       });
//                     } else {
//                       showSnackbar("User already exists with this email");
//                     }
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
//                     child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 20.sp)),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 50.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: 7.w),
//                 InkWell(
//                   onTap: signInWithGoogle,
//                   child: Container(
//                     padding: EdgeInsets.all(5),
//                     height: 40.h,
//                     decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       children: [
//                         Image(image: AssetImage("assets/image/google-logo-9808.png")),
//                         Text("   Google   ", style: TextStyle(fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 25.w,),
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   height: 40.h,
//                   decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image(image: AssetImage("assets/image/pngwing.com.png")),
//                       Text("   Apple  ", style: TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Text(" "),
//           ],
//
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

import '../auth/auth_serviece.dart';
import '../compnents/constructs.dart';
import '../compnents/my_button.dart';
import '../compnents/snackbar.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    if (_formKey.currentState!.validate()) {
      String res = await AuthenticationService().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        isLoading = false;
      });

      if (res == "Successfully") {
        CustomSnackBar.show(
          context,
          snackBarType: SnackBarType.success,
          label: "User registered successfully!",
          bgColor: Colors.green,
        );
        // Navigate to the login page if signup is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        CustomSnackBar.show(
          context,
          snackBarType: SnackBarType.fail,
          label: "User already exists",
          bgColor: Colors.red,
        );
        print("User already exists");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11002C),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.message,size: 45,),
                      const SizedBox(height: 20),
                      const Text("Create Account",
                          style: AppTypography.outfitboldmainHead),
                      const SizedBox(height: 10),
                      Text(
                        "Sign up to get started",
                        style: AppTypography.outfitboldsubHead.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: AppTypography.outfitRegular
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter your email';
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                            return 'Enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: AppTypography.outfitRegular
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                          if (value == null || value.isEmpty)
                            return 'Please enter your password';
                          if (value.length < 6)
                            return 'Password must be at least 6 characters';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: AppTypography.outfitRegular
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please confirm your password';
                          if (value != _passwordController.text)
                            return 'Passwords do not match';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const CircularProgressIndicator()
                          : CustomButton(
                        buttonName: "Sign Up",
                        onTap: signUpUser,
                        buttonColor: const Color(0xFF11002C),
                        height: 50,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Already have an account?",
                              style: AppTypography.outfitRegular.copyWith(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (Context) => LoginPage()),
                                    (route) => false,
                              );
                            },
                            child: Text(
                              "Login",
                              style: AppTypography.outfitBold.copyWith(
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