import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../Models/ProductsModel.dart';
import 'ProductDetails.dart';

// ignore: must_be_immutable
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          backgroundColor: Colors.transparent,
          title: Text(
            'All products',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder<List<Products>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1 / 1.5),
                      itemCount: data!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () async {
                          await Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              id: data[index].id.toString(),
                              data: data[index],
                            ),
                          ));
                          getData();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 180,
                              width: 180,
                              padding: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade200),
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20)),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: data[index].image,
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
                                width: 240,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ListTile(
                                contentPadding:
                                const EdgeInsets.only(top: 10),
                                title: Text(
                                  data[index].title,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${data[index].price}',
                                        style: const TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 14,
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
                        ),
                      )),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}