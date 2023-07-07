import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Complete_profile.dart';
import 'Home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> key = GlobalKey();
  var pass = TextEditingController(),
      email = TextEditingController(),
      conPass = TextEditingController(),
      _googleSignIn = GoogleSignIn(),
      loading = false;

  Future<void> googleSignIn() async {
    setState(() {
      loading = true;
    });
    GoogleSignInAccount? googleSignInAccount;

    googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      setState(() {
        loading = false;
      });
      return;
    }
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // ignore: use_build_context_synchronously

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (!value.exists) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              CompleteProfile(googleSignInAccount: googleSignInAccount),
        ));
      } else {
        Navigator.of(context).pushReplacementNamed('home');
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: [
                  Text(
                    "Register Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: .5,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Complete your details or continue\n with social media",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .2,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,

                  ),
                  SizedBox(height: 60,),
                  TextFormField(
                    validator: (value){
                      if (!value!.contains('@') && !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: email,
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 45,
                        vertical: 25,
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade800,
                          width: 1.5,
                        ),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 2,
                        letterSpacing: .5,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20 ,top: 14, bottom: 14 ),
                        child: SvgPicture.asset(
                          "assets/icons/Mail.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    validator: (value){
                      if (value!.length < 6) {
                        return 'Password should be at least 6 character';
                      }
                      return null;
                    },
                    controller: pass,
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 45,
                        vertical: 25,
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade800,
                          width: 1.5,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'Enter your Password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 2,
                        letterSpacing: .5,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 14, bottom: 14),
                        child: SvgPicture.asset(
                          "assets/icons/Lock.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    validator: (value){
                      if (value != pass.text) {
                        return 'Passwords not match';
                      }
                      return null;
                    },
                    controller: conPass,
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 45,
                        vertical: 25,
                      ),
                      border: OutlineInputBorder(
                        gapPadding: 10,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(40)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade800,
                          width: 1.5,
                        ),
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'Re-enter your password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 2,
                        letterSpacing: .5,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 14, bottom: 14),
                        child: SvgPicture.asset(
                          "assets/icons/Lock.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async{
                        if(!key.currentState!.validate()){
                          return;
                        }
                        try{
                          setState(() {
                            loading = true;
                          });
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email.text,
                            password: pass.text,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(e.message.toString()),
                            duration:  Duration(seconds: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          );
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: loading? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ): const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: Column(
                  //     children: [
                  //       TextField(
                  //         maxLines: 1,
                  //         decoration: InputDecoration(
                  //           enabledBorder: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius: BorderRadius.all(Radius.circular(40)),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey,
                  //               width: 1.5,
                  //             ),
                  //           ),
                  //           floatingLabelBehavior: FloatingLabelBehavior.always,
                  //           contentPadding: const EdgeInsets.symmetric(
                  //             horizontal: 45,
                  //             vertical: 25,
                  //           ),
                  //           border: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius:
                  //             const BorderRadius.all(Radius.circular(40)),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey.shade800,
                  //               width: 1.5,
                  //             ),
                  //           ),
                  //           labelText: 'Email',
                  //           labelStyle: TextStyle(
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           hintText: 'Enter your email',
                  //           hintStyle: TextStyle(
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.w500,
                  //             wordSpacing: 2,
                  //             letterSpacing: .5,
                  //           ),
                  //           suffixIcon: Padding(
                  //             padding: const EdgeInsets.only(right: 20 ,top: 14, bottom: 14 ),
                  //             child: SvgPicture.asset(
                  //               "assets/icons/Mail.svg",
                  //               fit: BoxFit.contain,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 20,),
                  //       TextField(
                  //         maxLines: 1,
                  //         decoration: InputDecoration(
                  //           enabledBorder: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius: BorderRadius.all(Radius.circular(40)),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey,
                  //               width: 1.5,
                  //             ),
                  //           ),
                  //           floatingLabelBehavior: FloatingLabelBehavior.always,
                  //           contentPadding: const EdgeInsets.symmetric(
                  //             horizontal: 45,
                  //             vertical: 25,
                  //           ),
                  //           border: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius:
                  //             const BorderRadius.all(Radius.circular(40)),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey.shade800,
                  //               width: 1.5,
                  //             ),
                  //           ),
                  //           labelText: 'Password',
                  //           labelStyle: TextStyle(
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           hintText: 'Enter your Password',
                  //           hintStyle: TextStyle(
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.w500,
                  //             wordSpacing: 2,
                  //             letterSpacing: .5,
                  //           ),
                  //           suffixIcon: Padding(
                  //             padding: const EdgeInsets.only(right: 20, top: 14, bottom: 14),
                  //             child: SvgPicture.asset(
                  //               "assets/icons/Lock.svg",
                  //               fit: BoxFit.contain,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 20,),
                  //       TextField(
                  //         maxLines: 1,
                  //         decoration: InputDecoration(
                  //           enabledBorder: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius: BorderRadius.all(Radius.circular(40)),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey,
                  //               width: 1.5,
                  //             ),
                  //           ),
                  //           floatingLabelBehavior: FloatingLabelBehavior.always,
                  //           contentPadding: const EdgeInsets.symmetric(
                  //             horizontal: 45,
                  //             vertical: 25,
                  //           ),
                  //           border: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius:
                  //             const BorderRadius.all(Radius.circular(40)),
                  //             borderSide: BorderSide(
                  //               color: Colors.grey.shade800,
                  //               width: 1.5,
                  //             ),
                  //           ),
                  //           labelText: 'Confirm Password',
                  //           labelStyle: TextStyle(
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           hintText: 'Re-enter your password',
                  //           hintStyle: TextStyle(
                  //             color: Colors.grey,
                  //             fontWeight: FontWeight.w500,
                  //             wordSpacing: 2,
                  //             letterSpacing: .5,
                  //           ),
                  //           suffixIcon: Padding(
                  //             padding: const EdgeInsets.only(right: 20, top: 14, bottom: 14),
                  //             child: SvgPicture.asset(
                  //               "assets/icons/Lock.svg",
                  //               fit: BoxFit.contain,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 40,),
                  //       Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         height: 50,
                  //         child: ElevatedButton(
                  //           onPressed: () async{
                  //             if(!key.currentState!.validate()){
                  //               return;
                  //             }
                  //             try{
                  //               setState(() {
                  //                 loading = true;
                  //               });
                  //               await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  //                 email: email.text,
                  //                 password: pass.text,
                  //               );
                  //               Navigator.of(context).push(
                  //                 MaterialPageRoute(
                  //                 builder: (context) => const Home(),
                  //                 ),
                  //               );
                  //             } on FirebaseAuthException catch (e) {
                  //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //                 behavior: SnackBarBehavior.floating,
                  //                 content: Text(e.message.toString()),
                  //                 duration:  Duration(seconds: 5),
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(20),
                  //                 ),
                  //               ),
                  //               );
                  //             }
                  //             setState(() {
                  //               loading = false;
                  //             });
                  //           },
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.deepOrangeAccent,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //             ),
                  //           ),
                  //           child: loading? Center(
                  //             child: CircularProgressIndicator(
                  //               color: Colors.white,
                  //             ),
                  //           ): const Text(
                  //             'Continue',
                  //             style: TextStyle(
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.w400,
                  //               letterSpacing: .5,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(height: 25,),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(top:50, bottom: 20),
                    alignment: Alignment.center,
                    width: 155,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            googleSignIn();
                          },
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade200,
                            child: SvgPicture.asset(
                              'assets/images/google.svg',
                              fit: BoxFit.contain,
                              height: 15,
                            ),
                          ),
                        ),
                        InkWell(
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade200,
                            child: SvgPicture.asset(
                              'assets/images/facebook.svg',
                              fit: BoxFit.contain,
                              height: 15,
                            ),
                          ),
                        ),
                        InkWell(
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey.shade200,
                            child: SvgPicture.asset(
                              'assets/images/twitter.svg',
                              fit: BoxFit.contain,
                              height: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "By Continuing your confirm that you agree\nwith our Terms and Condition",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
