import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Screens/ForgotPassScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Complete_profile.dart';
import 'Home.dart';
import 'RegisterScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool remember = false;
  GlobalKey<FormState> key = GlobalKey();
  var pass = TextEditingController(),
      email = TextEditingController(),
      _googleSignIn = GoogleSignIn(),
      loading = false;

  auth() async {
    if (!key.currentState!.validate()) {
      return;
    }
    try {
      setState(() {
        loading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pass.text);
      // ignore: use_build_context_synchronously
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email.text);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Text(e.message.toString()),
        duration: const Duration(seconds: 5),
      ));
    }
    setState(() {
      loading = false;
    });
  }

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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()),);
      }
    });
    setState(() {
      loading = false;
    });
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      remember = prefs.getBool('remember') ?? false;
      if (remember) {
        email.text = prefs.getString('email')!;
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                   // color: Colors.black,
                    letterSpacing: .5,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  "Sign in with your email and password\n or continue with social media",
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
                  controller: email,
                  validator: (value){
                    if(!value!.contains("@")&& !value.contains('.')){
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
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
                  controller: pass,
                  validator: (value){
                    if(value!.length < 8 ){
                      return 'Password should be at least 8 character';
                    }
                    return null;
                  },
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
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.deepOrangeAccent,
                      value: remember,
                      onChanged: (value) {
                        setState(() {
                          remember = !remember;
                        });
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForgotPassScreen()));
                      },
                      child: Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: (){
                      auth();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: loading ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ) : Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top:60, bottom: 10),
                  alignment: Alignment.center,
                  width: 155,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          googleSignIn();
                        },
                        borderRadius: BorderRadius.all(Radius.circular(50)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 17,
                        letterSpacing: .5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                      },
                      child: const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
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
