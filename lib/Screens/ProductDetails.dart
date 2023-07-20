import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../Models/ProductsModel.dart';
import '../main.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  ProductDetails({super.key, this.id = '', this.data});
  String id;
  var data;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Map<String, dynamic> list = {};
  int count = 1;

  late Future<Products> futureProducts;

  Future<Products> fetchProducts() async {
    var url = Uri.parse('https://fakestoreapi.com/products/${widget.id}');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return Products.fromJson(jsonDecode(response.body));
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

  var color = ['E46C64', '7F6EB3', 'DBCCA1', 'FFFFFF'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FutureBuilder<Products>(
            future: fetchProducts(),
            builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 20, bottom: 12, top: 12),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.white : Colors.grey.shade300,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${data!.rate}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        SvgPicture.asset(
                          'assets/icons/Star Icon.svg',
                          fit: BoxFit.contain,
                          height: 13,
                          width: 13,
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
          ),
        ],
        backgroundColor:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.grey.shade200: HexColor('7c7d7d'),
        elevation: 0,
        leadingWidth: 60,
        leading: Container(
          margin: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
          padding: const EdgeInsets.only(left: 5),
          decoration:  BoxDecoration(
            color:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.white : Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(100),
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
              },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 15,
            ),
          ),
        ),
      ),
      body: FutureBuilder<Products>(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Container(
                color:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.grey.shade200: HexColor('7c7d7d'),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CachedNetworkImage(
                          width: 150,
                          imageUrl: data!.image.isEmpty ? data.image : data.image,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50))),
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(top: 50),
                        //   width: MediaQuery.of(context).size.width / 1.4,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: List.generate(
                        //         data['data'][c]['images'].isEmpty
                        //             ? 1
                        //             : data['data'][c]['images'].length,
                        //         (index) => InkWell(
                        //               onTap: () {
                        //                 setState(() {
                        //                   i = index;
                        //                 });
                        //               },
                        //               child: Container(
                        //                 height: 55,
                        //                 width: 55,
                        //                 padding: const EdgeInsets.all(10),
                        //                 decoration: BoxDecoration(
                        //                     border: Border.all(
                        //                         color: i == index
                        //                             ? Colors.deepOrangeAccent
                        //                             : Colors.transparent),
                        //                     color: Colors.white,
                        //                     borderRadius:
                        //                         const BorderRadius.all(
                        //                             Radius.circular(10))),
                        //                 child: CachedNetworkImage(
                        //                   imageUrl: data['data'][c]['images']
                        //                           .isEmpty
                        //                       ? data['image']
                        //                       : data['data'][c]['images']
                        //                           [index],
                        //                   placeholder: (context, url) =>
                        //                       Shimmer.fromColors(
                        //                           baseColor:
                        //                               Colors.grey.shade300,
                        //                           highlightColor:
                        //                               Colors.grey.shade100,
                        //                           child: Container(
                        //                             decoration: BoxDecoration(
                        //                                 color: Colors.amber,
                        //                                 borderRadius:
                        //                                     BorderRadius.all(
                        //                                         Radius
                        //                                             .circular(
                        //                                                 50))),
                        //                           )),
                        //                 ),
                        //               ),
                        //             )),
                        //   ),
                        // )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width,
                        decoration:  BoxDecoration(
                            color: ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.white : HexColor('333739') ,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20,bottom: 5),
                                child: Text(
                                  data.title,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: list.containsKey(widget.id)
                                            ? Colors.red.shade100
                                            : Colors.grey.shade200,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),
                                    child: IconButton(
                                        onPressed: () async {
                                          final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          if (list.containsKey(widget.id)) {
                                            list.remove(widget.id);
                                          } else {
                                            list.putIfAbsent(
                                                widget.id,
                                                    () => {
                                                  'title': widget.data.title,
                                                  'price': widget.data.price,
                                                  'image': widget.data.image,
                                                  'rate': widget.data.rate
                                                });
                                          }

                                          setState(() {});

                                          String encodedMap = json.encode(list);
                                          setState(() {});

                                          prefs.setString('favorite', encodedMap);
                                        },
                                        icon: Icon(
                                          list.containsKey(widget.id)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: list.containsKey(widget.id)
                                              ? Colors.red
                                              : Colors.black,
                                        )),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20, left: 20),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  data.title,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.grey.shade700: Colors.grey.shade300,
                                      //color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, bottom: 30),
                                child: InkWell(
                                  child: Text(
                                    'See More Detail  >',
                                    style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      letterSpacing: .1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.grey.shade200: HexColor('7c7d7d'),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        margin: const EdgeInsets.only(left: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children:List.generate(
                                            4,
                                                (index) => Container(
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                                border: Border.all(
                                                    color: count == index
                                                        ? Colors.deepOrangeAccent
                                                        : Colors.transparent)),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  count = index;
                                                });
                                              },
                                              child: CircleAvatar(
                                                radius: 10,
                                                backgroundColor: Color(
                                                    int.parse('0xFF${color[index]}')),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                      const Spacer(),
                                      CircleAvatar(
                                      radius: 22,
                                      backgroundColor:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.white : Colors.grey.shade300,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.deepOrangeAccent,
                                          )),
                                    ),
                                      const SizedBox(
                                      width: 20,
                                    ),
                                      CircleAvatar(
                                      radius: 22,
                                      backgroundColor:  ECommerceApp.themeNotifier.value == ThemeMode.light ? Colors.white : Colors.grey.shade300,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.deepOrangeAccent,
                                          )),
                                    ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                  ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 38, bottom: 10),
        height: 100,
        decoration: const BoxDecoration(
          //  color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50),
          ),
        ),
        child: ElevatedButton(
          onPressed: () async {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'Add To Cart',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}