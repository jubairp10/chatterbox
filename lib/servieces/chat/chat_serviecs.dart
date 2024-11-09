import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService{
final FirebaseFirestore _firestore=FirebaseFirestore.instance;
/*



List<Map<String,dynamic>> =
[
{
  'email':example@email.com,
  'id':..
  }
  {
  'email':example@email.com,
  'id':..
  }
  ]
 */






Stream<List<Map<String,dynamic>>>getUsersStream(){
 return _firestore.collection('Users').snapshots().map((snapshot){
   return snapshot.docs.map((doc){
     final user= doc.data();
     return user;
   }).toList();
 });
}
}