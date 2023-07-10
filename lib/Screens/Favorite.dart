import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../Models/ProductsModel.dart';
import 'ProductDetails.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Map<String, dynamic> list = {};
  late Future<List<Products>> futureProducts;

  Future<List<Products>> fetchData() async {
    var url = Uri.parse('https://fakestoreapi.com/products');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body) as List<dynamic>;

      List<Products> products =
      decodeData.map((json) => Products.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Error');
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
    futureProducts = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Favorites',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: list.length == 0
            ? RefreshIndicator(
          onRefresh: () async {
            getData();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(child: Text('No favorites products yet!')),
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(10),
          child: RefreshIndicator(
            onRefresh: () async {
              getData();
            },
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.4),
                itemCount: list.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(
                      builder: (context) => ProductDetails(
                        id: list.keys.toList()[index],
                        data: Products(
                            id: int.parse(list.keys.toList()[index]),
                            title: list.values.toList()[index]
                            ['title'],
                            image: list.values.toList()[index]
                            ['image'],
                            price: list.values.toList()[index]
                            ['price'],
                            rate: list.values.toList()[index]
                            ['rate']),
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
                              width: 2, color: Colors.grey.shade200),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(20)),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: list.values.toList()[index]
                          ['image'],
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
                                            Radius.circular(50))),
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
                            list.values.toList()[index]['title'],
                            maxLines: 2,
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
                                  '\$${list.values.toList()[index]['price']}',
                                  style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                  Colors.red.shade100,
                                  child: IconButton(
                                    onPressed: () async {
                                      final SharedPreferences prefs =
                                      await SharedPreferences
                                          .getInstance();
                                      list.remove(list.keys
                                          .toList()[index]
                                          .toString());

                                      setState(() {});

                                      String encodedMap =
                                      json.encode(list);
                                      setState(() {});

                                      prefs.setString(
                                          'favorite', encodedMap);
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/Heart Icon_2.svg',
                                      // ignore: deprecated_member_use
                                      color: Colors.red,
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
                )),
          ),
        ));
  }
}