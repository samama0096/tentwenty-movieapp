import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/interface/controllers/watch_controller.dart';
import 'package:movietestapp/interface/utils/constants/fixed_constants.dart';
import 'package:movietestapp/interface/utils/constants/paddings.dart';
import 'package:movietestapp/interface/utils/constants/text_constants.dart';
import 'package:movietestapp/interface/utils/constants/widgets/movie_header.dart';

class MovieDetailsView extends StatelessWidget {
  MovieDetailsView({super.key, required this.movie});
  final MovieModel movie;
  final watchViewController = Get.find<WatchViewController>();
  @override
  Widget build(BuildContext context) {
    // watchViewController.getGenresOfMovie(movie.id.toString());
    Size size = getSize(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title:
            CustomText.boldText(movie.title, color: Colors.white, fontSize: 20),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.5,
                // width: size.width,
                child: Hero(
                    tag: movie.id,
                    child: Material(child: movieHeader(size, context, movie))),
              ),
              SizedBox(
                child: Padding(
                  padding: AppPaddings.horizontalSymmetricPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fixedVerticalSpace(15),
                      CustomText.boldText('Genres', fontSize: 20),
                      fixedVerticalSpace(15),
                      Obx(() => watchViewController.genresLoading.value
                          ? const LinearProgressIndicator()
                          : SizedBox(
                              height: 50,
                              width: size.width * 0.9,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movie.genresnames.length,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding:
                                          AppPaddings.customSymmetricPadding(
                                              h: 4, v: 2),
                                      child: Chip(
                                          label: CustomText.smallText(
                                              movie.genresnames[i])),
                                    );
                                  }))),
                      fixedVerticalSpace(15),
                      CustomText.boldText('Overview', fontSize: 20),
                      fixedVerticalSpace(15),
                      CustomText.smallText(
                        movie.overview,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
