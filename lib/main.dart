
import 'package:chatterbox/pages/home_page.dart';
import 'package:chatterbox/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp()); // Replace MyApp with your main app widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final User? currentUser = FirebaseAuth.instance.currentUser;
                return
                  // ChatPage(
                  //     email: currentUser?.email ?? '');
                  HomeScreen(currentUserEmail: currentUser?.email ?? '');

                // Pass email to ChatView
              } else {
                return LoginPage();
              }
            }));
  }
}

// class AuthWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//           return HomePage();
//         } else {
//           return Login();
//         }
//       },
//     );
//   }
// }