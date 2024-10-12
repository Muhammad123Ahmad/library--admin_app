import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_todo_app/ui/post/add_post.dart';
import 'package:firestore_todo_app/utils/utils.dart';
//import 'package:firestore_todo_app/utils/utils.dart';
import 'package:firestore_todo_app/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ShowPostScreen extends StatefulWidget {
  const ShowPostScreen({super.key});

  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {

  //final ref = FirebaseDatabase.instance.ref('Post');
  final searchText = TextEditingController();
  final editnameController = TextEditingController();
  final editcatController = TextEditingController();
  final editdescController = TextEditingController();

  String  bookname = "";
  String  bookdesc = "";
  String  bookcategory = "";
   String  docid = "";

  FirebaseAuth auth = FirebaseAuth.instance;

  //final fireStore = FirebaseFirestore.instance.collection('bookdetails').where('BookName',isEqualTo: 'gg').snapshots(); to get data on  where condition
final fireStore = FirebaseFirestore.instance.collection('bookdetails').snapshots();
  final ref1 = FirebaseFirestore.instance.collection('bookdetails');

  //final ref2 = FirebaseFirestore.instance.collection('bookdetails').get(); // for fututre builder to get data 

  //late Query  query;

  @override
  // void initState() {
  //   // TODO: implement initState

  //   query = ref.orderByChild('uid').equalTo(auth.currentUser!.uid); // setting condition that  uid is eqaul to user id so that he should only see his task only
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Show Data',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        automaticallyImplyLeading: false ,
        

        backgroundColor: const Color(0xff8207ed),
      ),

      body: Column(
        children: [

          const SizedBox( height: 10,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchText,
              decoration:const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            onChanged: (String value){
              setState(() {
                
              });
            },
            ),
            
          ),

          StreamBuilder<QuerySnapshot>(stream: fireStore, builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){

            if (snapshot.connectionState == ConnectionState.waiting)
            {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError){
              return const  Text('Some Error');
            }

             if (snapshot.hasData)
            {
              return Expanded(child: ListView.builder(
            
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              bookname  = snapshot.data!.docs[index]['BookName'];
              bookcategory  = snapshot.data!.docs[index]['BookCategory'];
              bookdesc  = snapshot.data!.docs[index]['BookDescription'];
              docid = snapshot.data!.docs[index].id;
              

              return 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  decoration:  BoxDecoration(
                    color:  const Color.fromARGB(104, 190, 87, 216),
                    borderRadius: BorderRadius.circular(12)
                    
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                  
                  [
                    
                  
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: 
                      [
                        Padding(
                    padding: const EdgeInsets.only(top: 8.0,left:8,bottom: 8),
                    child: Text('Book Name: $bookname ',style:const TextStyle(fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,bottom: 8),
                    child: Text('Book Category: $bookcategory',style:const TextStyle(fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Book Description: $bookdesc',style:const TextStyle(fontSize: 16),),
                  ),
                  
                      ],
                    ),
                    PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context)=>[
                  
                       PopupMenuItem(
                        value: 1,
                        
                        child:const ListTile(
                          leading:  Icon(Icons.edit),  
                          title:  Text('Edit'),
                        
                        ),
                        
                        onTap: () {
                         showMyDialog(bookname,bookcategory,bookdesc, docid);
                          
                        }, 
                        
                        ),

                         PopupMenuItem(
                        value: 2,
                        
                        child: const ListTile(
                          leading:  Icon(Icons.delete),  
                          title:  Text('Delete'),
                        
                        ),
                        onTap: () {

                          snapshot.data!.docs[index].reference.delete();
                          
                        },
                         ),
                    ]),
                  
                  ],
                  
                  
                  ),
                  
                ),
              );
              
              // ListTile(

              //   title: Text(snapshot.data!.docs[index]['BookDescription']
              //   ),
              //   subtitle: Text(snapshot.data!.docs[index]['BookName']),
              // );
        
            },
            
            ));
            }

            return  const SizedBox();
            




          }),

          






/*

// Code to get simple data without search bar
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context,snapshot,animation,index){

                return ListTile(

                  title: Text(snapshot.child('title').value.toString()),
                  subtitle:  Text(snapshot.child('id').value.toString()),

                );
              }),
          ),

*/
      /////////////// Fututre builder code to get data 
        // FutureBuilder(future: ref2, 
        
        // builder:(BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){

        //   return Expanded(
        //     child: ListView.builder(
        //       itemCount: snapshot.data!.docs.length,
              
        //       itemBuilder: (context,index){
        //         return ListTile(
        //           title: Text(snapshot.data!.docs[index]['BookName']),
        //         );
        //       }
        //     ),
        //   );


        // }),

        ///////////
        
         

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RoundButton(onTap: (){
            
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddPostScreen()));
            
            }, title: 'Add new data'),
          )

          

        ],
      ),


    );
    
  }

  // function contains code for edit text
  Future<void> showMyDialog( String bname,String bcat,String bdesc, String id)async{
    editnameController.text = bname;
    editcatController.text = bcat;
    editdescController.text = bdesc;
    return showDialog(
      context: context,
      builder: (BuildContext context){

        return  AlertDialog(

          title:  const Text('Update'),
          content: 
          Column(
            children: [
              TextField(
            controller: editnameController,
            decoration: const InputDecoration(hintText: "Enter new book name"),

          ),
          const SizedBox(height: 6,),
          TextField(
            controller: editcatController,
            decoration: const InputDecoration(hintText: "Enter new category"),

          ),
           const SizedBox(height: 6,),
          TextField(
            controller: editdescController,
            decoration: const InputDecoration(hintText: "Enter new description"),

          ),
            ],
          ),
          actions: [
             TextButton(onPressed: (){ Navigator.pop(context);}, child: const Text('Cancel')),
             TextButton(onPressed: (){ 
              Navigator.pop(context);
              ref1.doc(id).update({
                'BookName' : editnameController.text.toLowerCase(), // prefilling the dialouge with current bookname
                'BookCategory' : editcatController.text.toLowerCase(),
                'BookDescription' : editdescController.text.toLowerCase(),

              }).then((value){

                Utils().toastMessage('Post Added Successfully');

              }).onError((error,stackTrace){
                Utils().toastMessage(error.toString());

              });
             
             }, child: const Text('Update')), 
          ],

        );



      }

    );

  }
// function for edit text ends here 
  
}