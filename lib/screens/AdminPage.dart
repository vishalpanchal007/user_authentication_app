import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_authentication_app/FirestoreHelper.dart';

class AdminPage extends StatefulWidget {

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  String? email;
  String? password;
  String? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcad2c5),
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color(0xff2b2d42),
        title: Text('AdminPage'),
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
                    trailing:  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    'Update Detail',
                                    style: GoogleFonts.habibi(fontSize: 18),
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      style: GoogleFonts.balooBhaijaan2(
                                        color: Colors.white,
                                        fontSize: 17
                                      ),
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.black38,
                                        hintText: 'Email',
                                        hintStyle: GoogleFonts.balooBhaijaan2(
                                          color: Colors.white54,
                                          fontSize: 17
                                        ),
                                        prefixIcon:Icon(
                                          CupertinoIcons.mail,
                                          color: Colors.white,
                                        ) ,
                                        contentPadding: EdgeInsets.only(
                                          left: 14,
                                          top: 8
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black26
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black26
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                        )
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      style: GoogleFonts.balooBhai2(
                                          color: Colors.white, fontSize: 17),
                                      controller: roleController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.black38,
                                        hintText: 'Role',
                                        hintStyle: GoogleFonts.balooBhai2(
                                            color: Colors.white54, fontSize: 17),
                                        prefixIcon: const Icon(
                                          CupertinoIcons.person,
                                          color: Colors.white,
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 14.0, top: 8),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black26),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black26),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      String id = data[i].id;

                                      email = emailController.text;
                                      role = roleController.text;

                                      Map<String, dynamic> updateData = {
                                        'email': email,
                                        'password': data[i]['password'],
                                        'role': role,
                                      };

                                      FireStoreHelper.fireStoreHelper
                                          .updateUserData(
                                          data: updateData, id: id);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.edit_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      String id = data[i].id;

                                      FireStoreHelper.fireStoreHelper
                                          .deleteUserData(id: id);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      emailController.clear();
                                      roleController.clear();
                                      email = null;
                                      role = null;
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                        );
                      },
                      icon: const Icon(
                        Icons.category_outlined,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Center(
                  child: Text(
                    'Add User',
                    style: GoogleFonts.habibi(fontSize: 18),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      style: GoogleFonts.balooBhai2(
                          color: Colors.white, fontSize: 17),
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black38,
                        hintText: 'Email',
                        hintStyle: GoogleFonts.balooBhai2(
                            color: Colors.white54, fontSize: 17),
                        prefixIcon: const Icon(
                          CupertinoIcons.mail,
                          color: Colors.white,
                        ),
                        contentPadding:
                        const EdgeInsets.only(left: 14.0, top: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: GoogleFonts.balooBhai2(
                          color: Colors.white, fontSize: 17),
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black38,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.balooBhai2(
                            color: Colors.white54, fontSize: 17),
                        prefixIcon: const Icon(
                          CupertinoIcons.lock,
                          color: Colors.white,
                        ),
                        contentPadding:
                        const EdgeInsets.only(left: 14.0, top: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: GoogleFonts.balooBhai2(
                          color: Colors.white, fontSize: 17),
                      controller: roleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black38,
                        hintText: 'Role',
                        hintStyle: GoogleFonts.balooBhai2(
                            color: Colors.white54, fontSize: 17),
                        prefixIcon: const Icon(
                          CupertinoIcons.person,
                          color: Colors.white,
                        ),
                        contentPadding:
                        const EdgeInsets.only(left: 14.0, top: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async{
                      email = emailController.text;
                      password = passwordController.text;
                      role = roleController.text;

                      Map<String, dynamic> data = {
                        'email': email,
                        'password': password,
                        'role': role,
                      };


                      DocumentReference docRef = await FireStoreHelper.fireStoreHelper.registerData(data: data);
                      print(docRef.id);

                      setState(() {
                        emailController.clear();
                        passwordController.clear();
                        roleController.clear();
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add User Successfully...'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      emailController.clear();
                      roleController.clear();
                      email = null;
                      role = null;
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
