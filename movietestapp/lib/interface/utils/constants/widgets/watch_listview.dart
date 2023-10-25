import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietestapp/interface/controllers/watch_controller.dart';
import 'package:movietestapp/interface/views/home_view_tabs/movie_details_view.dart';

import '../../../../data/models/movie_model.dart';
import '../api_constants.dart';
import '../fixed_constants.dart';
import '../paddings.dart';
import '../text_constants.dart';

//list view used to show movie cards on WatchView (when showSearch is false)
Widget watchListView({
  required BuildContext context,
  required List<MovieModel> movies,
  required Size size,
}) =>
    ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              final watchViewController = Get.find<WatchViewController>();
              if (!watchViewController.isCachedUsed.value) {
                watchViewController.getGenresOfMovie(movies[i].id.toString());
              }

              Get.to(() => MovieDetailsView(movie: movies[i]));
            },
            child: Hero(
              tag: movies[i].id,
              child: Material(
                child: Padding(
                    padding: AppPaddings.customSymmetricPadding(h: 10, v: 10),
                    child: Stack(
                      children: [
                        Center(
                          child: movies[i].bg.isEmpty
                              ? const SizedBox()
                              : ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(medBorderRadius),
                                  child: Container(
                                    height: size.height * 0.25,
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ]),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                '${ApiConstants.imageEndPoint}${movies[i].bg}'))),
                                  ),
                                ),
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(medBorderRadius),
                            child: Container(
                              height: size.height * 0.25,
                              width: size.width * 0.9,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter,
                                    colors: [Colors.black, Colors.transparent]),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: AppPaddings.customSymmetricPadding(
                                  h: 8, v: 8),
                              child: CustomText.boldText(movies[i].title,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
