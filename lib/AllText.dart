import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  final String text1;
  final String text2;

  const Info(this.text1, this.text2, {Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 15),
      child: (Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.text1,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.text2,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      )),
    );
  }
}

class Vdivider extends StatelessWidget {
  const Vdivider({super.key});
  @override
  Widget build(context) {
    return const SizedBox(
        width: 5,
        height: 65,
        child: VerticalDivider(
            width: 1,
            thickness: 1,
            indent: 15,
            endIndent: 5,
            color: Colors.white));
  }
}

class HeroSec extends StatelessWidget {
  final String day;
  final String date;
  const HeroSec(this.day, this.date, {super.key});
  @override
  Widget build(context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                day,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(date,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w200))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Info("200", "Total"),
              Vdivider(),
              Info("50", "Stock In"),
              Vdivider(),
              Info("110", "Stock Out")
            ],
          )
        ],
      ),
    ));
  }
}
