import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:medical_app/custom_widget/app_bar.dart';

import 'package:medical_app/models/chart_model.dart';

class BmiCharts extends StatefulWidget {
  final List lineData;
  final String xData;
  final String yData;
  final String yTitle;

  const BmiCharts({Key key, this.xData, this.yData, this.yTitle, this.lineData})
      : super(key: key);
  @override
  _BmiChartsState createState() => _BmiChartsState();
}

class _BmiChartsState extends State<BmiCharts> {
  
  List<charts.Series> _seriesLineData;
  _genarateData() {
    var lineBmiData = widget.lineData
        .map((rep) => BmiData(
            date: DateTime.parse(rep[widget.xData]),
            bmiValue: double.parse(rep[widget.yData].toStringAsFixed(2))))
        .toList();
    _seriesLineData.add(charts.Series<BmiData, DateTime>(
        domainFn: (BmiData task, _) => task.date,
        data: lineBmiData,
        measureFn: (BmiData task, _) => task.bmiValue,
        id: 'BMI',
        colorFn: (_, m) => charts.ColorUtil.fromDartColor(Colors.red)));
  }

  @override
  void initState() {
    super.initState();
    _seriesLineData = List<charts.Series<BmiData, DateTime>>();
    _genarateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomAppBar(
              title: widget.yTitle,
              traile: IconButton(
                  icon: Icon(Icons.home, color: Colors.white,),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/HomePage');
                  }),
            ),
            Container(
              height: 400,
              width: 300,
              child: charts.TimeSeriesChart(
                _seriesLineData,
                behaviors: [
                  charts.ChartTitle('Date',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                  charts.ChartTitle(widget.yTitle,
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
