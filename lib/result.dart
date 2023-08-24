import 'package:flutter/material.dart';
import 'package:flutter_application_rating/meal_api.dart';
import 'package:flutter_application_rating/my_chart.dart';

class Result extends StatefulWidget {
  const Result({ Key? key }) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  dynamic chartPage = Text('차트영역');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         IconButton(onPressed: () async{
          //dt 2023-08-23 00:00:00
          var dt = await showDatePicker(
            context: context, 
            initialDate: DateTime.now(), 
            firstDate: DateTime(2023), 
            lastDate: DateTime.now(),
          );
          if(dt != null) {
            var api = MealApi();
            var result = await api.getList(evalDate: dt);
            print(result);
            List<String> days =[];
            List<double> ratings =[];
            for(var k in result){
              days.add(k['eval_date']);
              ratings.add(double.parse(k['rating']));
            }
            // print(days);
            // print(ratings);
            setState(() {
              chartPage = MyChart(days: days, ratings: ratings);
            });
          }
         }, icon: Icon(Icons.calendar_month)),
         Expanded(child: chartPage),
        ],
      ),
    );
  }
}