import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'SignIn.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int current = 0;
  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              const Text(
                'TOKOTO',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepOrangeAccent),
              ),
              const Text("Welcome to Tokoto, Let's shop!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 60,),
              CarouselSlider(
                carouselController: controller,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                    },
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height / 3.5,
                ),
                items: [1, 2, 3,].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset('assets/images/splash_$i.png');
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2,].asMap().entries.map((entry) {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0,),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepOrangeAccent.withOpacity(
                          current == entry.value ? 1 : 0.2),
                    ),
                  );
                }).toList(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 150,right:5 ,left: 5),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 20),
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