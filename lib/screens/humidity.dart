import 'package:safe_home/main.dart';
import 'package:flutter/material.dart';
import 'room_detail.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Humidity extends StatelessWidget {
  //const Humidity({Key key}) : super(key: key);
  final String id;
  Humidity(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Humidity'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('finalhmd')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // snapshot.data.documents.forEach((element) { })
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data.docs.reversed;

                  List<Text> sensordata = [];
                  // dataa.clear(); clearing previous data
                  // dataa2.clear();

                  for (var message in messages) {
                    String humidity = message.get('humidity');
                    String time = message.get('time');
                    int userId = message.get('id');
                    String useridstring = userId.toString();

                    double timeInMin = double.parse(time);

                    double humidityInDouble = double.parse(humidity);
                    if (useridstring == id) {
                      SensorData s = SensorData(humidityInDouble, timeInMin);

                      // dataa.clear();
                      // dataa2.clear();

                      dataa.add(s);
                    }
                  }
                  return SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                          enableDoubleTapZooming: true,
                          enablePanning: true,
                          zoomMode: ZoomMode.x),
                      title: ChartTitle(text: "Humidity"),
                      primaryXAxis: NumericAxis(
                          title: AxisTitle(text: 'Time(Hours.minutes)')),
                      primaryYAxis:
                          NumericAxis(title: AxisTitle(text: 'Percentage')),
                      series: <ChartSeries>[
                       BarSeries<SensorData, double>(
                          dataSource: getSensorData(),
                          xValueMapper: (SensorData sd, _) => sd.value,
                          yValueMapper: (SensorData sd, _) => sd.time,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: false,
                          ),
                        )
                      ]);
                }),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class SensorData {
  double time;
  double value;

  SensorData(this.time, this.value);
}

List<SensorData> dataa = <SensorData>[];

List<SensorData> dataa2 = [];

List<SensorData> getSensorData() {
  for (int i = 0; i < dataa.length; i++) {
    double x = dataa[i].time;
    double y = dataa[i].value;
    print("$x,$y");
    // SensorData s = SensorData(x, y);
    //dataa.add(s);
  }
  return dataa;
}
