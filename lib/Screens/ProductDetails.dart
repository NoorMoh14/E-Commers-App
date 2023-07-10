import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import '../Models/ProductsModel.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [
          Container(
            width: 60,
            margin: const EdgeInsets.only(right: 20, bottom: 14, top: 14),
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.data.rate.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                const SizedBox(
                  width: 5,
                ),
                SvgPicture.asset(
                  'assets/icons/Star Icon.svg',
                  fit: BoxFit.contain,
                  height: 10,
                  width: 10,
                ),
              ],
            ),
          )
        ],
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
        leadingWidth: 60,
        leading: Container(
            margin: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
            padding: const EdgeInsets.only(left: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 15,
              ),
            )),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: CachedNetworkImage(
                imageUrl: widget.data.image,
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                    )),
                width: 250,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                          widget.data.title,
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
                          widget.data.title,
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade700),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 30),
                        child: InkWell(
                          child: Text(
                            'See More Detail >',
                            style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   width: 150,
                                //   margin: const EdgeInsets.only(left: 20),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: List.generate(
                                //       0,
                                //       (index) => Container(
                                //         padding: const EdgeInsets.all(7),
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 const BorderRadius.all(
                                //                     Radius.circular(50)),
                                //             border: Border.all(
                                //                 color: c == index
                                //                     ? Colors
                                //                         .deepOrangeAccent
                                //                     : Colors.transparent)),
                                //         child: InkWell(
                                //           onTap: () {
                                //             setState(() {
                                //               c = index;
                                //             });
                                //           },
                                //           child: CircleAvatar(
                                //             radius: 10,
                                //             // backgroundColor: Color(int.parse(
                                //             //     '0xFF${data['data'][index]['color']}')),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // const Spacer(),
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      onPressed: () {
                                        if (count > 1) {
                                          setState(() {
                                            count--;
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.deepOrangeAccent,
                                      )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  count.toString(),
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.deepOrangeAccent,
                                      )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ]),
                        ),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding:
          const EdgeInsets.only(left: 50, right: 50, top: 40, bottom: 10),
          height: 100,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
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
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}