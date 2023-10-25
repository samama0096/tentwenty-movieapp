import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/interface/utils/constants/fixed_constants.dart';
import 'package:movietestapp/interface/utils/constants/paddings.dart';
import 'package:movietestapp/interface/utils/constants/text_constants.dart';
import 'package:movietestapp/interface/utils/constants/widgets/movie_header.dart';
import 'package:movietestapp/interface/utils/themes/app_theme.dart';

class PaymentView extends StatelessWidget {
  const PaymentView(
      {super.key, required this.movie, required this.formatedDate});
  final MovieModel movie;
  final String formatedDate;

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            }),
        centerTitle: true,
        title: Column(
          children: [
            CustomText.normalText(movie.title),
            CustomText.boldText(
              formatedDate,
              fontSize: 10,
              color: bluePrimary,
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.zoom_in),
            CustomText.smallText('Pinch to zoom'),
            fixedVerticalSpace(20),
            Hero(
              tag: 'hall',
              child: Container(
                height: s.height * 0.3,
                width: s.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(medBorderRadius),
                    border: Border.all(color: bluePrimary, width: 2)),
                child: InteractiveViewer(
                    child: Image.asset('lib/assets/images/hall.png')),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppPaddings.customSymmetricPadding(h: 16, v: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText.smallText('Total price'),
                CustomText.boldText('\$ 50'),
              ],
            ),
            MaterialButton(
                color: bluePrimary,
                minWidth: s.width * 0.6,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(smallBorderRadius),
                    borderSide: BorderSide.none),
                height: 50,
                child:
                    CustomText.boldText('Proceed to pay', color: Colors.white),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
