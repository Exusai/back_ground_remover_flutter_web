
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Height (without SafeArea)
    var padding = MediaQuery.of(context).padding;
    //double height1 = height - padding.top - padding.bottom;

    // Height (without status bar)
    //double height2 = height - padding.top;

    // Height (without status and toolbar)
    double height3 = height - padding.top - kToolbarHeight;
    return Container(
      height: height3,
      width: width,
      decoration: BoxDecoration(color: Colors.white),
      child: SpinKitCubeGrid(
        color: Colors.blue,
        size: 400.0,
      ),
    );
  }
}
