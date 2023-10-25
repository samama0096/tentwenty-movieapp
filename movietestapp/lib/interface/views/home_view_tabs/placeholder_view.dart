import 'package:flutter/material.dart';
import 'package:movietestapp/interface/utils/constants/text_constants.dart';

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomText.bodyText('Placeholder')),
    );
  }
}
