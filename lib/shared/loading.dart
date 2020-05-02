import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        color: Colors.white,
        child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_yIZkqk.json')
    ));
  }
}

class TinyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_y32Rtr.json')
    ));
  }
}