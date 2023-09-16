import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../FirestoreHelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  bool isPasswordShow = true;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffcad2c5),
      body: IndexedStack(
        index: currentIndex,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.15,
                ),
                Text(
                  'Create your Account',
                  style: GoogleFonts.yaldevi(
                      fontSize: 38,
                      letterSpacing: 2,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.15,
                ),
                TextField(
                  style:
                  GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
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
                    contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
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
                  style:
                  GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
                  controller: passwordController,
                  obscureText: isPasswordShow,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black38,
                    hintText: 'Password',
                    hintStyle: GoogleFonts.balooBhai2(
                        color: Colors.white54, fontSize: 17),
                    prefixIcon: const Icon(
                      CupertinoIcons.lock_fill,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordShow = !isPasswordShow;
                        });
                      },
                      icon: Icon(
                        (isPasswordShow)
                            ? CupertinoIcons.eye_fill
                            : CupertinoIcons.eye_slash_fill,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
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
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    email = emailController.text;
                    password = passwordController.text;

                    Map<String, dynamic> data = {
                      'email': email,
                      'password': password,
                      'role': 'user',
                    };


                    DocumentReference docRef = await FireStoreHelper.fireStoreHelper.registerData(data: data);
                    print(docRef.id);

                    setState(() {
                      currentIndex=1;
                      emailController.clear();
                      passwordController.clear();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign up Successfully...'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: width * 0.7,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff7210ff),
                        borderRadius: BorderRadius.circular(35)),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have an Account?',
                      style: GoogleFonts.balooBhai2(
                          fontSize: 15, color: Colors.black87),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                          emailController.clear();
                          passwordController.clear();
                        });
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.balooBhai2(
                            fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // signIn
          StreamBuilder(
              stream: FireStoreHelper.fireStoreHelper.loginData(),
              builder: (context, snapshot){
                if(snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'),);
                }else if(snapshot.hasData){

                  QuerySnapshot<Map<String, dynamic>>? querySnapshot = snapshot.data;
                  List res = querySnapshot!.docs;

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.15,
                        ),
                        Text(
                          'Login to your Account',
                          style: GoogleFonts.yaldevi(
                              fontSize: 36,
                              letterSpacing: 2,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.15,
                        ),
                        TextField(
                          style:
                          GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
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
                            contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
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
                          style:
                          GoogleFonts.balooBhai2(color: Colors.white, fontSize: 17),
                          controller: passwordController,
                          obscureText: isPasswordShow,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black38,
                            hintText: 'Password',
                            hintStyle: GoogleFonts.balooBhai2(
                                color: Colors.white54, fontSize: 17),
                            prefixIcon: const Icon(
                              CupertinoIcons.lock_fill,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordShow = !isPasswordShow;
                                });
                              },
                              icon: Icon(
                                (isPasswordShow)
                                    ? CupertinoIcons.eye_fill
                                    : CupertinoIcons.eye_slash_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(left: 14.0, top: 8),
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
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: () async {

                            bool isLogin = false;

                            email = emailController.text;
                            password = passwordController.text;

                            for(QueryDocumentSnapshot data in res){
                              if(email==data['email']&&password==data['password']){
                                isLogin = true;

                                if(data['role'] == 'admin'){
                                  Navigator.of(context).pushReplacementNamed('adminPage');
                                }else{
                                  Navigator.of(context).pushReplacementNamed('homepage');
                                }
                                break;
                              }
                            }

                            if(isLogin==true){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sign In Successfully...'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sign In failed...'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }

                          },
                          child: Container(
                            height: 50,
                            width: width * 0.7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xff7210ff),
                                borderRadius: BorderRadius.circular(35)),
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.balooBhai2(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account?",
                              style: GoogleFonts.balooBhai2(
                                  fontSize: 15, color: Colors.black87),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentIndex = 0;
                                  emailController.clear();
                                  passwordController.clear();
                                });
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.balooBhai2(
                                    fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              }
          )
        ],
      ),
    );
  }
}
