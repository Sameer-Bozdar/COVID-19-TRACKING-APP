import 'package:covid_tracker/View/World_Statics.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
String image;
  int? totalCases,
  deaths,
  totalDeaths,
  active,
  critical,
  todayRecovered,
  tests;

  DetailScreen({Key? key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.deaths,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.tests,

  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ReusableRow(
                        title: 'cases', value: widget.totalCases.toString()),
                    ReusableRow(
                        title: 'totalDeaths',
                        value: widget.totalDeaths.toString()),
                    ReusableRow(
                        title: 'totalRecovered',
                        value: widget.todayRecovered.toString()),
                    ReusableRow(
                        title: 'active', value: widget.active.toString()),
                    ReusableRow(
                        title: 'critical', value: widget.critical.toString()),
                    ReusableRow(title: 'tests', value: widget.tests.toString()),



                  ],
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.image),
              )

            ],
          )
        ],
      ),
    );
  }
}
