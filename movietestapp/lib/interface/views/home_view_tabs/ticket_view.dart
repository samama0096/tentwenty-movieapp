import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/interface/utils/constants/fixed_constants.dart';
import 'package:movietestapp/interface/utils/constants/paddings.dart';
import 'package:movietestapp/interface/utils/constants/text_constants.dart';
import 'package:movietestapp/interface/utils/constants/widgets/movie_header.dart';
import 'package:movietestapp/interface/utils/themes/app_theme.dart';
import 'package:movietestapp/interface/views/home_view_tabs/payment_view.dart';

class TicketView extends StatelessWidget {
  TicketView({super.key, required this.movie, required this.formatedDate});
  final MovieModel movie;
  final String formatedDate;
  final dates = List<DateTime>.generate(
      20,
      (i) => DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).add(Duration(days: i)));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText.boldText('Date'),
            SizedBox(
              width: s.width * 0.9,
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: AppPaddings.rightPadding,
                      child: Chip(
                          backgroundColor:
                              i == 0 ? bluePrimary : Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(smallBorderRadius)),
                          label: Text(
                            '${dates[i].day} ${months['${dates[i].month}']!.substring(0, 3)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: i == 0 ? Colors.white : Colors.black54),
                          )),
                    );
                  }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText.boldText('12:30'),
                    fixedHorzSpace(10),
                    CustomText.smallText('Cinepax+Hall 1')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                      height: s.height * 0.2,
                      width: s.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Hero(
                            tag: 'hall',
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(medBorderRadius),
                                  border:
                                      Border.all(color: bluePrimary, width: 2)),
                              child: Image.asset('lib/assets/images/hall.png'),
                            ),
                          ),
                          fixedHorzSpace(15),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(medBorderRadius),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5)),
                            child: Image.asset('lib/assets/images/hall.png'),
                          )
                        ],
                      )),
                ),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: 'From ', style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: '\$50',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  TextSpan(text: ' or', style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: ' 2500',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: '  bonus', style: TextStyle(color: Colors.black)),
                ])),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppPaddings.customSymmetricPadding(h: 16, v: 10),
        child: MaterialButton(
            color: bluePrimary,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(smallBorderRadius),
                borderSide: BorderSide.none),
            height: 50,
            child: CustomText.boldText('Select Seats', color: Colors.white),
            onPressed: () {
              Get.to(
                  () => PaymentView(movie: movie, formatedDate: formatedDate));
            }),
      ),
    );
  }
}
