import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 40,),
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
                SizedBox(height: 35,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextField(
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
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.email_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
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
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.lock_outline,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
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
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.lock_outline,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:40, bottom: 30),
                  alignment: Alignment.center,
                  width: 190,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade200,
                          child: SvgPicture.asset(
                            'assets/icons/google.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      InkWell(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade200,
                          child: SvgPicture.asset(
                            'assets/icons/facebook.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      InkWell(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade200,
                          child: SvgPicture.asset(
                            'assets/icons/twitter.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "By Continuing your confirm that you agree\nwith our terms and condition",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
