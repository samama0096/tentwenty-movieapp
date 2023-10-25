import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/data/services/movie_service.dart';
import 'package:movietestapp/interface/utils/constants/api_constants.dart';
import 'package:movietestapp/interface/utils/constants/widgets/player_view.dart';
import 'package:movietestapp/interface/views/home_view_tabs/ticket_view.dart';

import '../fixed_constants.dart';
import '../text_constants.dart';

Widget movieHeader(Size size, BuildContext context, MovieModel movie) {
  String formattedDate =
      'In Theaters ${months[movie.releaseDate.split('-')[1]]} ${movie.releaseDate.split('-').last}, ${movie.releaseDate.split('-').first}';
  return Stack(children: [
    Center(
      child: CachedNetworkImage(
        imageUrl: '${ApiConstants.imageEndPoint}${movie.bg}',
        height: size.height * 0.5,
        fit: BoxFit.fill,
      ),
    ),
    Container(
      height: size.height * 0.5,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black26),
      child: SizedBox(
        width: size.width * 0.6,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomText.bodyText(formattedDate, color: Colors.white),
          fixedVerticalSpace(10),
          MaterialButton(
              minWidth: size.width * 0.6,
              height: 50,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Get.to(() => TicketView(
                      movie: movie,
                      formatedDate: formattedDate,
                    ));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(smallBorderRadius)),
              child: CustomText.smallText('Get Tickets', color: Colors.white)),
          fixedVerticalSpace(10),
          MaterialButton(
              minWidth: size.width * 0.6,
              height: 50,
              color: Colors.transparent,
              onPressed: () async {
                MovieService movieService = MovieService();
                var res =
                    await movieService.fetchMovieTrailer(movie.id.toString());

                Get.to(() => VideoPlayerView(
                      url: res.trim(),
                    ));
              },
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(smallBorderRadius),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  CustomText.smallText('Watch Trailer', color: Colors.white),
                ],
              )),
          fixedVerticalSpace(10)
        ]),
      ),
    ),
  ]);
}

Map<String, String> months = {
  '01': 'January',
  '02': 'Feburary',
  '03': 'March',
  '04': 'April',
  '05': 'May',
  '06': 'June',
  '07': 'July',
  '08': 'August',
  '09': 'September',
  '10': 'October',
  '11': 'November',
  '12': 'December'
};
