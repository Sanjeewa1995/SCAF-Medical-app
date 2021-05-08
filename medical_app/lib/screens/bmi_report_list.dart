import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_app/custom_widget/app_bar.dart';

class BmiReportList extends StatelessWidget {
 

   BmiReportList({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      List report = [{'height': 152, 'weight':65, 'bmiValue':28.13},
      {'height': 152, 'weight':65, 'bmiValue':28.13},
      {'height': 152, 'weight':65, 'bmiValue':28.13},
      {'height': 152, 'weight':65, 'bmiValue':28.13},
      {'height': 152, 'weight':65, 'bmiValue':28.13},
      {'height': 152, 'weight':65, 'bmiValue':28.13}
      ];
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Reports',
            traile: IconButton(
                color: Colors.white,
                iconSize: 30,
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/HomePage');
                }),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 50 - statusbarHeight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 0.0),
                  itemCount: report.length,
                  itemBuilder: (BuildContext context, index) {
                    // String date = DateFormat('yyyy/MM/dd')
                    //     .format(DateTime.parse(report[index]["regDate"]));
                    return Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: Material(
                        shadowColor: Color(0xFF35D6A6),
                        elevation: 7.0,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Color(0xFF19769F),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 10.0,
                              ),
                              Container(
                                  child: Text(
                                    '2020.05.23',
                                //date,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Color(0xFF19769F),
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(height: 7.0),
                              ReUseRow(
                                label: 'Height',
                                value:
                                    '${report[index]["height"].toString()}cm',
                              ),
                              ReUseRow(
                                label: 'Weight',
                                value:
                                    '${report[index]["weight"].toString()}kg',
                              ),
                              ReUseRow(
                                label: 'BMI',
                                value:
                                    '${report[index]["bmiValue"].toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class ReUseRow extends StatelessWidget {
  final String label;
  final String value;

  const ReUseRow({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Color(0xff06A7F6), fontSize: 18.0),
          ),
          //SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
            ),
            child: Text(value,
                style: TextStyle(color: Color(0xff06A7F6), fontSize: 18.0)),
          )
        ],
      ),
    );
  }
}
