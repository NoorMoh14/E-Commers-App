import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var search = TextEditingController(),
      index = 0,
      catTitle = ['Flash\nDeal', 'Bill\n', 'Game\n', 'Daily\nGift', 'More\n'],
      specialTitle = [
        'Smartphone',
        'Fashion',
      ],
      specialSub = [
        '18',
        '24',
      ],
      catIcon = [
        'Flash Icon',
        'Bill Icon',
        'Game Icon',
        'Gift Icon',
        'Discover'
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: ListView(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                      child: TextField(
                          controller: search,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search product',
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/Cart Icon.svg',
                        // ignore: deprecated_member_use
                        color:
                        index == 4 ? Colors.deepOrangeAccent : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/Bell.svg',
                        // ignore: deprecated_member_use
                        color:
                        index == 5 ? Colors.deepOrangeAccent : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: (){},
              icon: SvgPicture.asset("assets/icons/Shop Icon.svg"),
            ),
            IconButton(
              onPressed: (){},
              icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),),
            IconButton(
              onPressed: (){},
              icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),),
            IconButton(
              onPressed: (){},
              icon: SvgPicture.asset("assets/icons/User Icon.svg"),),
          ],
        ),
      ),
    );
  }
}