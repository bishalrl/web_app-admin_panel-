import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/utils/styles.dart';
import 'package:ecommerce/widgets/homecards.dart';
import 'package:flutter/material.dart';

List categories = ["Grocery", "Clothes", "Home ApplienceS", "Furniture"];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/room-chha-cd668.appspot.com/o/images%20of%20rooms%2F2023-09-26%2021%3A04%3A09.231297?alt=media&token=9f46542f-14ae-4242-aa13-13feff92fcb4'
        'https://firebasestorage.googleapis.com/v0/b/room-chha-cd668.appspot.com/o/images%20of%20rooms%2F2023-09-26%2021%3A04%3A09.231297?alt=media&token=9f46542f-14ae-4242-aa13-13feff92fcb4'
        'https://firebasestorage.googleapis.com/v0/b/room-chha-cd668.appspot.com/o/images%20of%20rooms%2F2023-09-26%2021%3A04%3A09.231297?alt=media&token=9f46542f-14ae-4242-aa13-13feff92fcb4'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Hello here",
                  style: EcoStyle.boldstyle,
                ),
              ),
              CarouselSlider(
                items: imageUrls
                    .map(
                      (imageUrl) => Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 280,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.blueAccent.withOpacity(0.3),
                              Colors.brown.withOpacity(0.3)
                            ])),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            left: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromARGB(255, 235, 191, 191)
                                          .withOpacity(0.5),
                                ),
                                child: const Text(
                                  "TITLE",
                                  style: EcoStyle.boldstyle,
                                ),
                              ),
                            ))
                      ]),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  height: 300,
                ),
              ),
              HomeCards(
                title: categories[0],
              ),
              HomeCards(
                title: categories[1],
              ),
              HomeCards(
                title: categories[2],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
