import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var search = TextEditingController(),
      index = 0,
      popular = [
        {'title': 'Wireless Controller for PS4™', 'price': '64.99'},
        {'title': 'Nike Sport White - Man Pant', 'price': '50.5'},
        {'title': 'Glover', 'price': '36.99'},
      ],
      special = [
        {'title': 'Smartphone', 'count': '18'},
        {'title': 'Fashion', 'count': '24'},
      ],
      cat = [
        {'title': 'Flash\nDeal', 'icon': 'Flash Icon'},
        {'title': 'Bill\n', 'icon': 'Bill Icon'},
        {'title': 'Game\n', 'icon': 'Game Icon'},
        {'title': 'Daily\nGift', 'icon': 'Gift Icon'},
        {'title': 'More\n', 'icon': 'Discover'}
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
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -3, end: 0),
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade200,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icons/Bell.svg',
                          // ignore: deprecated_member_use
                          color: index == 5
                              ? Colors.deepOrangeAccent
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 40),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                    color: Color(0xFF473393),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A Summer Surpise',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Cashback 20%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    cat.length,
                        (index) => Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(17),
                          decoration: const BoxDecoration(
                              color: Color(0xFFFCEDDF),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: SvgPicture.asset(
                            'assets/icons/${cat[index]['icon']}.svg',
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(cat[index]['title'].toString())
                      ],
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Special for you',
                    style: TextStyle(fontSize: 22),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See More',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ))
                ],
              ),
              Container(
                height: 115,
                margin: const EdgeInsets.only(bottom: 30, top: 15),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          child: Image.asset(
                            'assets/images/Image Banner ${index + 2}.png',
                            width: MediaQuery.of(context).size.width / 1.45,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.45,
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: ListTile(
                                title: Text(
                                  special[index]['title'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                contentPadding:
                                const EdgeInsets.only(top: 10, left: 25),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    '${special[index]['count']} Brands',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ))),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Products',
                    style: TextStyle(fontSize: 22),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See More',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ))
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                margin: const EdgeInsets.only(bottom: 30, top: 15),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Image.asset(
                            'assets/images/Image Popular Product ${index + 1}.png',
                            width: MediaQuery.of(context).size.width / 1.45,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(top: 10),
                            title: Text(
                              popular[index]['title'].toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${popular[index]['price']}',
                                    style: const TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: index == 0
                                        ? Colors.red.shade100
                                        : Colors.grey.shade200,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/icons/Heart Icon_2.svg',
                                        // ignore: deprecated_member_use
                                        color: index == 0
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
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