import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/constant/string_constant.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3), // Semi-transparent background
      child: Center(
        child: Lottie.asset(MyText.loaderLottie), // Loading spinner
      ),
    );
  }
}
