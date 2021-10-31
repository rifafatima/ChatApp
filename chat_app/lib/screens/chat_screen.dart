import 'package:chat_app/widgets/chats/messages.dart';
import 'package:chat_app/widgets/chats/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override

  void initState(){
    super.initState();
    final fbm=FirebaseMessaging();     //this configuration is for ios, android does not need permission
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg){
      print(msg);
      return;
    },
     onLaunch: (msg){
      print(msg);
      return;
    },
     onResume: (msg){
      print(msg);
      return;
    }
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.pink,      //Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ],)
                  ),
                  value: 'logout',
                  ),
            ],
            onChanged: (itemIdentifier){
              if(itemIdentifier == 'logout')
              {
                FirebaseAuth.instance.signOut();  //logout
              }
            },
          )
        ],
      ),
      body: Container(child: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
      ),
      
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //    Firestore.instance
      //    .collection('chats/WS4qlip5rFBN9lLjkW6O/messages')
      //    .add({'text': 'Added by button'});  //new document is represented by map in flutter
      //   },
      //   ),
    );
  }
}



 // Firestore.instance
          // .collection('chats/MLGBMzYMlw705MFyOrO5/messages')  //we want to access messages in id document in chats collection
          // .snapshots()        //snapshots call on a collection and returns a stream. Since it is a stream, that means it's going to emit new values whenever data changes, so that's the realtime aspect.
          // .listen((data) { 
          //   data.documents.forEach((document) {
          //     print(data.documents[0]['text']);  text was the key we used in our messages
          //   });
          //   });  

      //     StreamBuilder(
      //   stream: Firestore.instance
      //     .collection('chats/WS4qlip5rFBN9lLjkW6O/messages')  
      //     .snapshots(),
      //   builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot){   //whenever we get a new value, this function is executed
          
      //     if(streamSnapshot.connectionState ==ConnectionState.waiting)
      //     {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
          
      //     final documents=  streamSnapshot.data.documents;
      //     return ListView.builder(                //builder function is regenerated/re-executed whenever stream changes due to a new value
      //    itemCount: documents.length,
      //   itemBuilder: (ctx, index) => Container(
      //   child: Text(documents[index]['text']),
      //   padding: EdgeInsets.all(8),
      // ),
      // );
      // },
      // ),