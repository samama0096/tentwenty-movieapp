import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movietestapp/data/models/movie_model.dart';
import 'package:movietestapp/interface/controllers/search_controller.dart';
import 'package:movietestapp/interface/controllers/watch_controller.dart';
import 'package:movietestapp/interface/utils/constants/fixed_constants.dart';
import 'package:movietestapp/interface/utils/constants/paddings.dart';
import 'package:movietestapp/interface/utils/constants/text_constants.dart';
import 'package:movietestapp/interface/views/home_view_tabs/movie_details_view.dart';

import '../../utils/constants/api_constants.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final searchController = Get.find<GetSearchController>();
  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Obx(() => Center(
          child: SizedBox(
            height: s.height,
            width: s.width * 0.95,
            child: searchController.isSearching.value &&
                    searchController.searchResults.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Lottie.asset('lib/assets/lotties/loading-anim.json',
                            height: 50),
                        fixedVerticalSpace(10),
                        CustomText.smallText(
                            'Searching for *${searchController.enteredQuery.value}*')
                      ],
                    ),
                  )
                : Column(
                    children: [
                      //   CustomText.normalText('Top searches'),
                      Expanded(
                        child: ListView.builder(
                            itemCount: searchController.searchResults.length,
                            itemBuilder: (context, index) {
                              MovieModel movie =
                                  searchController.searchResults[index];
                              return SizedBox(
                                height: s.height * 0.2,
                                width: s.width,
                                child: Padding(
                                    padding: AppPaddings.topPadding,
                                    child: InkWell(
                                      onTap: () async {
                                        //getting genres of a searched movie
                                        final watchViewController =
                                            Get.find<WatchViewController>();
                                        var res = await watchViewController
                                            .getGenres(movie.id.toString());
                                        movie.genresnames = res;
                                        Get.to(() =>
                                            MovieDetailsView(movie: movie));
                                      },
                                      child: Card(
                                        elevation: 0,
                                        child: Row(
                                          children: [
                                            movie.bg.isEmpty
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                medBorderRadius),
                                                        border: Border.all(
                                                            color: Colors
                                                                .blueGrey)),
                                                    width: s.width * 0.4,
                                                    child: Center(
                                                        child: CircleAvatar(
                                                            radius: 50,
                                                            child: Text(movie
                                                                .title[0]))),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            medBorderRadius),
                                                    child: Hero(
                                                      tag: movie.id,
                                                      child: CachedNetworkImage(
                                                        width: s.width * 0.4,
                                                        height: s.height * 0.2,
                                                        imageUrl:
                                                            '${ApiConstants.imageEndPoint}${movie.bg}',
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                  ),
                                            fixedHorzSpace(10),
                                            //handling extra title text (large)
                                            CustomText.boldText(movie
                                                        .title.length >
                                                    15
                                                ? '${movie.title.substring(0, 15)} ...'
                                                : movie.title),
                                            fixedHorzSpace(10),
                                            const Spacer(),
                                            const Icon(Icons.more_horiz_rounded)
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            }),
                      ),
                    ],
                  ),
          ),
        ));
  }
}
