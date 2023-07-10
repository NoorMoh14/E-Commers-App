import 'dart:convert';
import 'package:e_commerce_app/Screens/ProductDetails.dart';
import 'package:e_commerce_app/Screens/AllProducts.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../Models/ProductsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var search = TextEditingController(),

      list = {},
      cat = [
        {'title': 'Flash\nDeal', 'icon': 'Flash Icon'},
        {'title': 'Bill\n', 'icon': 'Bill Icon'},
        {'title': 'Game\n', 'icon': 'Game Icon'},
        {'title': 'Daily\nGift', 'icon': 'Gift Icon'},
        {'title': 'More\n', 'icon': 'Discover'}
      ];

  late Future<List<Products>> futureProducts;

  Future<List<Products>> fetchProducts() async {
    var url = Uri.parse(
        'https://fakestoreapi.com/products');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body) as List<dynamic>;
        List<Products> products =
        decodedData.map((json) => Products.fromJson(json)).toList();
        return products;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      list = json.decode(prefs.getString('favorite').toString());
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
    futureProducts = fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width / 1.6,
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade200,
              child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/Cart Icon.svg',
                  // ignore: deprecated_member_use
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            child: badges.Badge(
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
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        leading: Container(
          margin: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 40, top: 20),
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
              FutureBuilder(
                  future:  fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var cat = snapshot.data;
                      return Container(
                        height: 115,
                        margin: const EdgeInsets.only(bottom: 30, top: 15),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: cat!.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: CachedNetworkImage(
                                    imageUrl: cat[index].image,
                                    width: MediaQuery.of(context).size.width /
                                        1.45,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 1.45,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 1.4,
                                    child: ListTile(
                                        title: Text(
                                          cat[index].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 10, left: 25),
                                        subtitle: Padding(
                                          padding:
                                          const EdgeInsets.only(top: 3),
                                          child: Text(
                                            '18 Brands',
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
                      );
                    }
                    return Container(
                        height: 115,
                        margin: const EdgeInsets.only(bottom: 30, top: 15),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          ),
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.45,
                                height: 150,
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                              )),
                        ));
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Products',
                    style: TextStyle(fontSize: 22),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ));
                      },
                      child: const Text(
                        'See More',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ))
                ],
              ),
              FutureBuilder(
                  future: fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var pop = snapshot.data;
                      return Container(
                        height: MediaQuery.of(context).size.height / 3,
                        margin: const EdgeInsets.only(bottom: 30, top: 15),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: pop!.length == 0 ? 0 : 3,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: ()  async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    id: pop[index].id.toString(),
                                    data: pop[index],
                                  ),
                                ));
                                getData();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 160,
                                    width: 160,
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2,
                                          color: Colors.grey.shade200),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: pop[index].image,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                              Colors.grey.shade100,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            50))),
                                              )),
                                      width: 250,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 2.5,
                                    child: ListTile(
                                      contentPadding:
                                      const EdgeInsets.only(top: 10),
                                      title: Text(
                                        pop[index].title,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$${pop[index].price}',
                                              style: const TextStyle(
                                                color: Colors.deepOrangeAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            RefreshIndicator(
                                                onRefresh: () async {
                                                  getData();
                                                },
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: list.containsKey(
                                                      pop[index].id.toString())
                                                      ? Colors.red.shade100
                                                      : Colors.grey.shade200,
                                                  child: IconButton(
                                                    onPressed: ()async {
                                                      final SharedPreferences prefs = await SharedPreferences.getInstance();

                                                      setState(() {
                                                        if (list.containsKey(pop[index].id.toString())) {
                                                          list.remove(pop[index].id.toString());
                                                        } else {
                                                          list.putIfAbsent(
                                                              pop[index].id.toString(), () => {
                                                            'title': pop[index].title,
                                                            'price': pop[index].price,
                                                            'image': pop[index].image,
                                                            'rate': pop[index].rate
                                                          });
                                                        }

                                                        String encodedMap = json.encode(list);
                                                        prefs.setString('favorite', encodedMap);
                                                      });

                                                    },
                                                    icon: SvgPicture.asset(
                                                      'assets/icons/Heart Icon_2.svg',
                                                      color:  list.containsKey(
                                                          pop[index].id.toString())
                                                          ? Colors.red
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container(
                        height: 150,
                        margin: const EdgeInsets.only(bottom: 30, top: 15),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          ),
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 160,
                                width: 160,
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                              )),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}