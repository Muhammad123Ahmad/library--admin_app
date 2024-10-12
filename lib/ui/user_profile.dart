import 'package:firestore_todo_app/ui/auth/login_screen.dart';
import 'package:firestore_todo_app/utils/utils.dart';
import 'package:firestore_todo_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  FirebaseAuth auth =FirebaseAuth.instance;

  String name = '';
  String email = '';
  String id = '';

  DatabaseReference db = FirebaseDatabase.instance.ref('Users'); 

  void getData()async{

    var snap =await db.child(FirebaseAuth.instance.currentUser!.uid).get();
    if (snap.child('name').exists){
      setState(() {
        name = snap.child('name').value.toString();
        email = snap.child('email').value.toString();
        id = snap.child('uid').value.toString();
      });
    }

  }
  

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
getData();
  }
  @override
  
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(),

    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

       const  SizedBox( height: 60,),
        const CircleAvatar(
            radius: 80,
              backgroundImage:AssetImage('assets/user.png'),
            ),

      const  SizedBox( height: 60,),

     Text(
      overflow: TextOverflow.ellipsis
      ,'Name: $name',style: const TextStyle(fontSize: 25), ),
                const  SizedBox( height: 5,),
                Text(      overflow: TextOverflow.ellipsis
,'Email: $email',style: const TextStyle(fontSize: 25),),
                const  SizedBox( height: 5,),
            const  SizedBox( height: 5,),
                Text('User ID: $id',style: const TextStyle(fontSize: 16),),
        

        
        Padding(
          padding: const EdgeInsets.all(20),
          child: RoundButton(onTap: (){
            auth.signOut().then((value) {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginScreen()));
            }).onError((error,stackTrace){
              Utils().toastMessage(error.toString());
          
            });
          }, title: 'LogOut'),
        )
      ],
    ),
    );
  }
}