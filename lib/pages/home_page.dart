// import 'package:chatterbox/auth/auth_serviece.dart';
// import 'package:chatterbox/servieces/chat/chat_serviecs.dart';
// import 'package:flutter/material.dart';
//
// import '../compnents/my_drawer.dart';
// import '../compnents/user_tile.dart';
// import 'chatpage.dart';
// class  HomePage extends StatelessWidget {
//   final ChatService _chatService=ChatService();
//   final FirebaseHelper _firebaseHelper=FirebaseHelper();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home'),
//
//
//       ),
//       drawer: MyWidget(),
//       body: _buildUserList(),
//     );
//   }
//   Widget _buildUserList(){
//     return StreamBuilder(stream: _chatService.getUsersStream(), builder: (context,snapshot){
//       if (snapshot.hasError){
//         return Text('Error');
//       }
//       if(snapshot.connectionState==ConnectionState.waiting){
//         return Text('Loading..');
//       }
//       return ListView(
//
//         children:
//           snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData,context)).toList(),
//
//       );
//     });
//   }
//   Widget _buildUserListItem (Map<String,dynamic>userData,BuildContext context){
//     return  UserTile(text: 'email', onTap: () {
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>
//           Chatpage(recievedEmail: userData['email'],)));
//
//     },);
//   }
// }

import 'package:chatterbox/compnents/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../compnents/constructs.dart';
import 'chatpage.dart';
import 'login_page.dart';


class HomeScreen extends StatefulWidget {
  final String currentUserEmail;

  const HomeScreen({Key? key, required this.currentUserEmail})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> _usersStream() {
    return _firestore.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyWidget(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          'Chat Users',
          style: AppTypography.outfitboldsubHead
              .copyWith(color: Colors.white, fontSize: 20),
        ),

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter out current user and create user list
          final users = snapshot.data!.docs
              .where((doc) => doc['email'] != widget.currentUserEmail)
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final userEmail = userData['email'] as String;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(email: userEmail),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.purple.shade50,
                          Colors.purple.shade100,
                        ],
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.purple.shade200,
                        child: Text(
                          userEmail[0].toUpperCase(),
                          style: AppTypography.outfitboldsubHead.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      title: Text(
                        userEmail,
                        style: AppTypography.outfitboldsubHead.copyWith(
                          color: Colors.purple.shade700,
                          fontSize: 16,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}