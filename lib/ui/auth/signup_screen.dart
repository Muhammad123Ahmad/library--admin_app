import 'package:firestore_todo_app/ui/auth/login_screen.dart';
import 'package:firestore_todo_app/utils/utils.dart';
import 'package:firestore_todo_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>(); // to check that from field is empty or not 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final  db = FirebaseDatabase.instance.ref('Users'); // creating new node name USERS in firebase to store user information
   bool loading = false;

  FirebaseAuth _auth =FirebaseAuth.instance; //creating instance 

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(title:  const Text('Sign Up',style: TextStyle(color: Colors.white),),backgroundColor: const Color(0xff8207ed), centerTitle: true,
    ),
      body:   Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: 
       [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(children: [

              TextFormField(controller: nameController,
              keyboardType: TextInputType.emailAddress,
          
          decoration: const InputDecoration(
            hintText: 'Name',
            prefixIcon: Icon(Icons.person), 
          ),
          
          validator: (value){
            if (value!.isEmpty){
              return 'Enter name';
            }
            return null;
          },
                
          ),

          const SizedBox(height: 20,),


          
              TextFormField(controller: emailController,
              keyboardType: TextInputType.emailAddress,
          
          decoration: const InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.alternate_email), 
          ),
          
          validator: (value){
            if (value!.isEmpty){
              return 'Enter email';
            }
            return null;
          },
                
          ),
          
          const SizedBox(height: 20,),
           TextFormField(controller: passwordController,
           keyboardType: TextInputType.text,
           obscureText: true,
          
          decoration: const InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock_open), 
          ),
          validator: (value){
            if (value!.isEmpty){
              return 'Enter password';
            }
            return null;
          },
          
          ),
          
          ],)),
        ),

        const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundButton(
            title: 'Sign up',
            loading: loading,
            
            onTap: (){if (_formkey.currentState!.validate()){  
            setState(() {
                  loading = true;
                });
            _auth.createUserWithEmailAndPassword(
              email: emailController.text.toString(), password: passwordController.text.toString()).then((value){


                db.child(value.user!.uid).set({ // this contain code to add user email,pass,uid in new node that we created above in refrence area

                  'email' : emailController.text.toString().trim(),
                  'name' : nameController.text.toString().trim(),
                  'uid': value.user!.uid,
                });

                setState(() {
                  loading = false;
                });

              }).onError((error,stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading = false;
                });
              });
          }}, ),
        ),

         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=> const LoginScreen()));
            }, child:const  Text('Login'))
          ],
        )

      ],),
      
  );
  }
}