import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Screens/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                // FutureBuilder(
                //     future: FirebaseFirestore.instance
                //         .collection('users')
                //         .doc(FirebaseAuth.instance.currentUser!.uid)
                //         .get(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         return CircleAvatar(
                //           radius: 50,
                //           backgroundImage:
                //           snapshot.data!.data()!['image'].toString().isEmpty
                //               ? null
                //               : CachedNetworkImageProvider(
                //               snapshot.data!.data()!['image']),
                //           child:
                //           snapshot.data!.data()!['image'].toString().isEmpty
                //               ? Container(
                //             height: 40,
                //             width: 40,
                //             child: SvgPicture.asset(
                //               'assets/icons/User Icon.svg',
                //               // ignore: deprecated_member_use
                //               color: Colors.black,
                //             ),
                //           )
                //               : null,
                //           backgroundColor: Colors.deepOrangeAccent,
                //         );
                //       }
                //       return SizedBox();
                //     }),
                CircleAvatar(
                  radius: 50,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: SvgPicture.asset(
                      'assets/icons/User Icon.svg',
                      // ignore: deprecated_member_use
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.deepOrangeAccent,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Noor Odeh",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .1,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.deepOrangeAccent.shade100,
                  endIndent: 30,
                  indent: 30,
                  thickness: 1,
                ),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepOrange.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/icons/Settings.svg',
                          color: Colors.deepOrangeAccent,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepOrangeAccent,
                      size: 20,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.deepOrangeAccent.shade100,
                  endIndent: 30,
                  thickness: 1,
                  indent: 30,
                ),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepOrange.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/icons/Question mark.svg',
                          // ignore: deprecated_member_use
                          color: Colors.deepOrangeAccent,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                      'Help Center',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  trailing: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepOrangeAccent,
                      size: 20,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.deepOrangeAccent.shade100,
                  thickness: 1,
                  endIndent: 30,
                  indent: 30,
                ),
                ListTile(
                  onTap: ()  {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
                  },
                  leading:Padding(
                    padding: EdgeInsets.all(10),
                    child:CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.deepOrange.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/icons/Log out.svg',
                          // ignore: deprecated_member_use
                          color: Colors.deepOrangeAccent,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}