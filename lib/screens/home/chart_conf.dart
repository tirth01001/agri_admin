


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget getTitles(List<String> years,double value, TitleMeta meta,{String type="y"}) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    //Month Data Extractor
    if(type == "m"){

      Map<String, String> monthName = {
        "M1": "Jan",
        "M2": "Feb",
        "M3": "Mar",
        "M4": "Apr",
        "M5": "May",
        "M6": "Jun",
        "M7": "Jul",
        "M8": "Aug",
        "M9": "Sep",
        "M10": "Oct",
        "M11": "Nov",
        "M12": "Dec",
      };
      // print(monthName.keys.contains(years.));
      years.sort((a, b) => int.parse(a.substring(1)).compareTo(int.parse(b.substring(1))));
      
      return SideTitleWidget(
        meta: meta,
        space: 4,
        child: Text(monthName[years[int.parse(value.toString())]].toString(), style: style),
      );
    }
    
    
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(years[int.parse(value.toString())], style: style),
    );
  }




BarTouchData get barTouchData => BarTouchData(
  enabled: false,
  touchTooltipData: BarTouchTooltipData(
    getTooltipColor: (group) => Colors.transparent,
    tooltipPadding: EdgeInsets.zero,
    tooltipMargin: 8,
    getTooltipItem: (
      BarChartGroupData group,
      int groupIndex,
      BarChartRodData rod,
      int rodIndex,
    ) {
      return BarTooltipItem(
        rod.toY.round().toString(),
        const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
    },
  ),
);



FlTitlesData titlesData(List<DocumentSnapshot> data,{String type="y"}) {
  
  List<String> years = [];

  if(type=="y"){
    for(int i=0;i<data.length;i++){
      years.add(data[i].id);
    }
  }else if(type=="m"){
    Map<String,dynamic> dobj = (data.last.data() as Map<String,dynamic>);
    List<String> keys = dobj.keys.toList();
    for(int i=0;i<keys.length;i++){
      if(keys[i].contains("total")) { continue;}
      years.add(keys[i]);
    }
  }

  

  return FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (value, meta) => getTitles(years, value, meta,type: type),
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

}

FlBorderData get borderData => FlBorderData(
  show: false,
);

LinearGradient get _barsGradient => LinearGradient(
    colors: [
      // Colors.orange,
      // Colors.orangeAccent,
      Colors.black,
      Colors.grey
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );


List<BarChartGroupData> barGroups(List<DocumentSnapshot> data,{String type="y"}) {

  List<double> yaxis = [];

  if(type == "y"){
    yaxis = List.generate(data.length, (index){
      DocumentSnapshot snaps  = data[index];
      return snaps.get('total').toDouble();
    });
  }else if ( type == "m"){
    Map<String,dynamic> dobj = (data.last.data() as Map<String,dynamic>);
    List<String> keys = dobj.keys.toList();
    keys.removeWhere((ele) => ele=="total");
    // print(keys);
    // print(data.length);
    yaxis = List.generate(keys.length, (index){
      
      Map<String,dynamic> valu  = data.last.get(keys[index]);
      return valu["total"].toDouble();
    });
  }
  double maxValue = yaxis.reduce((a, b) => a > b ? a : b);
  double scaleFactor = 100.0 / maxValue;  // Scaling factor to fit data between 0 and 100

  return List.generate(yaxis.length, (index){
    double scaledValue = yaxis[index] * scaleFactor;  // Scale each y-value
    return BarChartGroupData(
      x: index,  // Make sure this is unique for each data point
      barRods: [
        BarChartRodData(
          toY: scaledValue,  // Use scaled value
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    );
  });

}

// List<BarChartGroupData> get barGroups => [
  // BarChartGroupData(
  //   x: 0,
  //   barRods: [
  //     BarChartRodData(
  //       toY: 8,
  //       gradient: _barsGradient,
  //     )
  //   ],
  //   showingTooltipIndicators: [0],
  // ),
//   BarChartGroupData(
//     x: 1,
//     barRods: [
//       BarChartRodData(
//         toY: 10,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 2,
//     barRods: [
//       BarChartRodData(
//         toY: 14,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 3,
//     barRods: [
//       BarChartRodData(
//         toY: 15,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
  // BarChartGroupData(
  //   x: 4,
  //   barRods: [
  //     BarChartRodData(
  //       toY: 13,
  //       gradient: _barsGradient,
  //     )
  //   ],
  //   showingTooltipIndicators: [0],
  // ),
  // BarChartGroupData(
  //   x: 5,
  //   barRods: [
  //     BarChartRodData(
  //       toY: 10,
  //       gradient: _barsGradient,
  //     )
  //   ],
  //   showingTooltipIndicators: [0],
  // ),
  // BarChartGroupData(
  //   x: 6,
  //   barRods: [
  //     BarChartRodData(
  //       toY: 16,
  //       gradient: _barsGradient,
  //     )
  //   ],
  //   showingTooltipIndicators: [0],
  // ),
// ];

