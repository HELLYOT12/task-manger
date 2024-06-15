import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class GraphicPage extends StatelessWidget {
  // TODO: BUILD IT WITH FL_CHART
  const GraphicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: MediaQuery.sizeOf(context).height/10,bottom: 10,left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Activity',style: TextStyle(fontSize: 24,fontFamily: 'Roboto-Bold'),),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height/3,
              child: Chart(
                data: [
                  { 'genre': 'Sports', 'sold': 275 },
                  { 'genre': 'Strategy', 'sold': 115 },
                  { 'genre': 'Action', 'sold': 120 },
                  { 'genre': 'Shooter', 'sold': 350 },
                  { 'genre': 'Other', 'sold': 150 },
                ],
                variables: {
                  'genre': Variable(
                    accessor: (Map map) => map['genre'] as String,
                  ),
                  'sold': Variable(
                    accessor: (Map map) => map['sold'] as num,
                  ),
                },
                marks: [IntervalMark()],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
