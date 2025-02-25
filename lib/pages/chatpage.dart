// import 'package:flutter/material.dart';
// class Chatpage extends StatelessWidget {
//   final String recievedEmail;
//   const Chatpage ({Key? key, required this.recievedEmail}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(recievedEmail),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:chatterbox/pages/setting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../compnents/constructs.dart';
import 'home_page.dart';
import 'login_page.dart';

class ChatPage extends StatefulWidget {
  final String email;
  const ChatPage({Key? key, required this.email}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(email: email);
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  final String email;
  _ChatPageState({required this.email});

  final FirebaseFirestore fs = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      fs.collection('messages').add({
        'message': messageController.text.trim(),
        'time': DateTime.now(),
        'email': email,
      });
      messageController.clear();
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          widget.email,
          style: AppTypography.outfitboldsubHead
              .copyWith(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    currentUserEmail: _auth.currentUser?.email ?? "",
                  )),
                  (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              _auth.signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageScreen(email: email),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.purple[50],
                      hintText: 'Type a message...',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.purple, width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2 * pi,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.purple),
                        onPressed: _sendMessage,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}