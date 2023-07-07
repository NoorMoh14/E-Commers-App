import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class CompleteProfile extends StatefulWidget {
  CompleteProfile({super.key, required this.googleSignInAccount});

  GoogleSignInAccount? googleSignInAccount;

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  GlobalKey<FormState> key = GlobalKey();
  var phone = TextEditingController(),
      fName = TextEditingController(),
      lName = TextEditingController(),
      image = '',
      address = TextEditingController(),
      loading = false;

  @override
  void initState() {
    if (widget.googleSignInAccount != null) {
      fName.text = widget.googleSignInAccount!.displayName!.split(' ')[0];
      lName.text = widget.googleSignInAccount!.displayName!.split(' ')[1];
      image = widget.googleSignInAccount!.photoUrl.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                const Text(
                  'Complete Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Complete your details or continue \n with social media',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    controller: fName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 25),
                        border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        labelText: 'First Name',
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        hintText: 'Enter your first name',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 13, bottom: 13),
                          child: SvgPicture.asset(
                            'assets/icons/User Icon.svg',
                            // ignore: deprecated_member_use
                            color: Colors.black87,
                            fit: BoxFit.contain,
                          ),
                        ))),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    controller: lName,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 25),
                        border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        labelText: 'Last Name',
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        hintText: 'Enter your last name',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 13, bottom: 13),
                          child: SvgPicture.asset(
                            'assets/icons/User Icon.svg',
                            // ignore: deprecated_member_use
                            color: Colors.black87,
                            fit: BoxFit.contain,
                          ),
                        ))),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.length < 10) {
                        return 'Please enter your Phone number';
                      }
                      return null;
                    },
                    controller: phone,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 25),
                        border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        hintText: 'Enter your phone number',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 13, bottom: 13),
                          child: SvgPicture.asset(
                            'assets/icons/Phone.svg',
                            fit: BoxFit.contain,
                          ),
                        ))),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    controller: address,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 25),
                        border: OutlineInputBorder(
                            gapPadding: 10,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            borderSide:
                            BorderSide(color: Colors.grey.shade800)),
                        labelText: 'Address',
                        labelStyle: TextStyle(color: Colors.grey.shade800),
                        hintText: 'Enter your address',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 13, bottom: 13),
                          child: SvgPicture.asset(
                            'assets/icons/Location point.svg',
                            fit: BoxFit.contain,
                          ),
                        ))),
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!key.currentState!.validate()) {
                        return;
                      }
                      try {
                        setState(() {
                          loading = true;
                        });
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'firstName': fName.text,
                          'lastName': lName.text,
                          'phone': phone.text,
                          'address': address.text,
                          'image': image.isEmpty ? '' : image,
                          'email': FirebaseAuth.instance.currentUser!.email,
                          'uid': FirebaseAuth.instance.currentUser!.uid,
                          'type': widget.googleSignInAccount == null
                              ? 'password'
                              : 'google.com'
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacementNamed('home');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          content: const Text('Something happened'),
                          duration: const Duration(seconds: 5),
                        ));
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
                    child: loading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : const Text(
                      'Continue',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'By continuing your confirm that you agree \n with our Term and Condition',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}