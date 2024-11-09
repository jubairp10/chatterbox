import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auth_serviece.dart';
import '../pages/login_page.dart';
import '../pages/setting_page.dart';
class MyWidget extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Icon(Icons.message,color:Theme.of(context).colorScheme.primary ,
                  size: 40,),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(title: Text('H O M E'),
                  leading: Icon(Icons.home),
                  onTap: (){
                  Navigator.pop(context);
                  },),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(title: Text('S E T T I N G S'),
                  leading: Icon(Icons.settings),
                  onTap: (){

                  },),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 25),
            child: ListTile(title: Text('L O  G O U T'),
              leading: Icon(Icons.logout),
              onTap: (){
                _auth.signOut().whenComplete(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                });
              },),
          ),
        ],
      ),
    );
  }
}
