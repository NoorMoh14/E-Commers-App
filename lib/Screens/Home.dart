import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Chat.dart';
import 'Favorite.dart';
import 'HomeScreen.dart';
import 'Profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          HomeScreen(),
          FavoritesScreen(),
          ChatScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
           // color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    index = 0;
                  });
                },
                icon: SvgPicture.asset(
                  'assets/icons/Shop Icon.svg',
                  // ignore: deprecated_member_use
                  color: index == 0 ? Colors.deepOrangeAccent : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },
                icon: SvgPicture.asset(
                  'assets/icons/${index == 1 ? 'Heart Icon_2' : 'Heart Icon'}.svg',
                  // ignore: deprecated_member_use
                  color: index == 1 ? Colors.deepOrangeAccent : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    index = 2;
                  });
                },
                icon: SvgPicture.asset(
                  'assets/icons/Chat bubble Icon.svg',
                  // ignore: deprecated_member_use
                  color: index == 2 ? Colors.deepOrangeAccent : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    index = 3;
                  });
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacementNamed('signIn');
                },
                icon: SvgPicture.asset(
                  'assets/icons/User Icon.svg',
                  // ignore: deprecated_member_use
                  color: index == 3 ? Colors.deepOrangeAccent : Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}