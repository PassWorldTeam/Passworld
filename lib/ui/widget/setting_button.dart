import 'package:flutter/material.dart';

class SettingButtonWidget extends StatelessWidget {
  String title;
  String content;
  IconData icon;

  SettingButtonWidget(
      {super.key,
      required this.title,
      required this.content,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    // Media Query
    var size = MediaQuery.of(context).size;
    double w = size.width; //* MediaQuery.of(context).devicePixelRatio;
    double h = size.height; // * MediaQuery.of(context

    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.all(h * 0.02),
              child: Row(children: [
                Icon(
                  icon,
                  size: w * 0.08,
                  color: Colors.white,
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.05)),
                    Text(
                      content,
                      style: TextStyle(fontSize: w * 0.02, color: Colors.black),
                    )
                  ],
                )
              ]),
            ),
          ),
        )
      ],
    );
  }
}
