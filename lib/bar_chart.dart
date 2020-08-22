import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartData {
  final String domain;
  final double measure;

  BarChartData(this.domain, this.measure);

  static List<BarChartData> allFromMap(maps){
    List<BarChartData> result = [];
    for(Map<String, dynamic> map in maps)
      result.add(BarChartData.fromMap(map));
    return result;
  }

  BarChartData.fromMap(Map<String, dynamic> map)
      : domain = map["domain"],
        measure = map["measure"];

  static List<Map<String, dynamic>> allToMap(List<BarChartData> allBarChartData){
    List<Map<String, dynamic>> result = [];
    log("mapping allBarChartData", name: allToMap.toString());
    for(BarChartData barChartData in allBarChartData)
      result.add(barChartData.toMap());
    log("mapping allBarChartData done", name: allToMap.toString());
    return result;
  }

  Map<String, dynamic> toMap() => {
  "domain": domain,
  "measure": measure,
  };

  String toString(){
    return "Domain: $domain, Measure: $measure";
  }
}

final sampleBarChartData = [
  BarChartData('abc', 30000),
  BarChartData('def', 10000),
  BarChartData('ghi', 2000),
  BarChartData('jkl', 25000),
  BarChartData('mno', 40000),
  BarChartData('pqr', 27000),
];

List<charts.Series<BarChartData, String>> barChartDataGenerator(
    List<BarChartData> data,
    {Color color: Colors.deepPurple}) {
  return [
    charts.Series<BarChartData, String>(
      id: "SharesPerCompany",
      domainFn: (BarChartData shareData, _) => shareData.domain,
      measureFn: (BarChartData shareData, _) => shareData.measure,
      seriesColor: convertColor(color),
      data: data,
    ),
  ];
}

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final MediaQueryData screen;

  BarChart(this.seriesList, this.animate, this.screen);

  @override
  Widget build(BuildContext context) {
    double screenWidth = screen.size.width;
    return charts.BarChart(
      seriesList,
      animate: animate,
      animationDuration: Duration(milliseconds: 1000),
//      barRendererDecorator: charts.BarLabelDecorator<String>(
//        insideLabelStyleSpec: charts.TextStyleSpec(
//          color: convertColor(Colors.white),
//        ),
//        outsideLabelStyleSpec: charts.TextStyleSpec(
//          color: convertColor(Colors.white),
//        ),
//      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: convertColor(Colors.white30),
            fontSize: (screenWidth * 0.03).toInt(),
          ),
          lineStyle: charts.LineStyleSpec(
            color: convertColor(Colors.white10),
          ),
        ),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: screen.orientation == Orientation.portrait ? 60 : 0,
          labelStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.white,
            fontSize: (screenWidth * 0.03).toInt(),
          ),
          lineStyle: charts.LineStyleSpec(color: convertColor(Colors.white30)),
        ),
      ),
//      behaviors: [
//        charts.SeriesLegend(),
//        charts.SlidingViewport(),
//        charts.PanAndZoomBehavior(),
//      ],
    );
  }
}

charts.Color convertColor(Color color) {
  return charts.Color(
    r: color.red,
    g: color.green,
    b: color.blue,
    a: color.alpha,
  );
}
