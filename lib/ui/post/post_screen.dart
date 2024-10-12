//import 'package:check1/ui/auth/login_screen.dart';
import 'package:firestore_todo_app/ui/post/add_post.dart';
import 'package:firestore_todo_app/ui/user_profile.dart';
//import 'package:check1/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  (const Text('Home',style: TextStyle(color: Colors.white),)),
        backgroundColor: const Color(0xff8207ed),

        actions:
        
         [
          
        /*  
          IconButton(
          onPressed: (){
          auth.signOut().then((value) {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoginScreen()));
          }).onError((error,stackTrace){
            Utils().toastMessage(error.toString());

          });
        }, icon: const Icon(Icons.logout)),
        */
        
        
        Padding(
         padding: const EdgeInsets.only(right:8.0),
         child:   InkWell(

          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const UserProfileScreen()));
          },
           child: const CircleAvatar(
            radius: 20,
              backgroundImage:AssetImage('assets/user.png'),
            ),
         ),
       ),
       

        ],

        ),

        floatingActionButton: FloatingActionButton(onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostScreen()));
        },

        child: const Icon(Icons.add),
        backgroundColor: const Color(0xff8207ed),
        
        ),

        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text('Books are the mirrors of the soul.', style: TextStyle(fontSize: 30,color:  Color (0xff8207ed), fontWeight: FontWeight.bold),),
            ),

            Image(image: AssetImage('assets/book1.png'))
          ],
        ),
        
    );
  }
}