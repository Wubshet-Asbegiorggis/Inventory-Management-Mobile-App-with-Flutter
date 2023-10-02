import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "package:inventory/AllText.dart";
import 'package:inventory/FCard.dart';
import 'package:inventory/NotificationScreen.dart';
import 'package:inventory/SearchBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
              child: Row(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                ),
                IconButton(
                    padding: const EdgeInsets.only(bottom: 5),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationPage()));
                    },
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                    ))
              ]),
            ),
            const Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const MySlider(),
            const SizedBox(
              height: 15,
            ),
            const SearChBar(),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 26,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const DisplayCard(),
          ],
        ),
      ),
    )));
  }
}

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int _currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = [
      Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromRGBO(107, 59, 225, 1)),
        child: const Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Lorem ipsum dolor sit amet.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Text(
                  "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(107, 59, 225, 1),
        ),
        child: const HeroSec("Today", "Aug 22"),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(107, 59, 225, 1),
        ),
        child: const HeroSec("Yesterday", "Aug 21"),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: carouselItems,
                options: CarouselOptions(
                  autoPlayCurve: Curves.decelerate,
                  autoPlay: true,
                  height: 180,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentSlide = index;
                    });
                  },
                ),
              ),
              Positioned(
                top: 12.0,
                right: 40.0,
                child: CarouselStatus(
                  itemCount: carouselItems.length,
                  currentSlide: _currentSlide,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CarouselStatus extends StatelessWidget {
  final int itemCount;
  final int currentSlide;

  const CarouselStatus(
      {super.key, required this.itemCount, required this.currentSlide});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int index = 0; index < itemCount; index++)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentSlide == index
                  ? const Color.fromARGB(255, 30, 69, 224)
                  : Colors.white,
            ),
          ),
      ],
    );
  }
}
