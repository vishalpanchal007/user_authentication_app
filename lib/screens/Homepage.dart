import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FirestoreHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcad2c5),
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color(0xff2b2d42),
        title: Text('HomePage'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login_page');
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.loginData(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? res = snapshot.data;
            List data = res!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    isThreeLine: true,
                    title: Text('${data[i]['email']}\n'),
                    subtitle: Text('Role: ${data[i]['role']}'),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
