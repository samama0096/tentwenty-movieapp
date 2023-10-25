import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietestapp/interface/controllers/internet_controller.dart';
import 'package:movietestapp/interface/controllers/watch_controller.dart';
import 'package:movietestapp/interface/utils/constants/fixed_constants.dart';
import 'package:movietestapp/interface/utils/constants/paddings.dart';
import 'package:movietestapp/interface/utils/constants/text_constants.dart';
import 'package:movietestapp/interface/utils/constants/widgets/simple_shimer.dart';
import 'package:movietestapp/interface/utils/constants/widgets/watch_listview.dart';
import 'package:movietestapp/interface/views/home_view_tabs/search_view.dart';

class WatchView extends StatelessWidget {
  WatchView({super.key});
  final watchViewController = Get.put(WatchViewController());
  //to check connection availability
  final internetController = Get.find<InternetController>();

  @override
  Widget build(BuildContext context) {
    Size s = getSize(context);
    return Material(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(s.width, 70),
              child: Obx(
                () => AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black87),
                  elevation: 1,
                  leadingWidth: 0,
                  toolbarHeight: 80,
                  automaticallyImplyLeading: false,
                  //if the search icon is clicked, there will be no actions
                  actions: watchViewController.showSearch.value
                      ? []
                      : [
                          IconButton(
                              onPressed: () {
                                watchViewController.toggleSearchButton();
                              },
                              icon: const Icon(Icons.search)),
                        ],

                  //when showSearch is true, a list tile for search will be shown.
                  title: watchViewController.showSearch.value
                      ? AnimatedContainer(
                          width: watchViewController.showSearch.value
                              ? double.infinity
                              : 0,
                          duration: const Duration(seconds: 1),
                          child: ListTile(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            minLeadingWidth: 0,
                            contentPadding: const EdgeInsets.all(0),
                            tileColor: Colors.grey.shade300,
                            horizontalTitleGap: 0,
                            title: Padding(
                              padding: AppPaddings.horizontalSymmetricPadding,
                              child: TextFormField(
                                autofocus: true,
                                decoration: const InputDecoration(
                                    fillColor: Colors.blueGrey,
                                    hintText: 'Tv shows, movies and more',
                                    enabledBorder: InputBorder.none),
                                controller: watchViewController.queryController,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                watchViewController.queryController.clear();
                              },
                            ),
                            leading: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                watchViewController.showSearch.value = false;
                              },
                            ),
                          ),
                        )
                      : CustomText.normalText('Watch', fontSize: 20),
                ),
              )),
          body: RefreshIndicator(
              onRefresh: () async {
                //when controller allows to refresh when connection is available and check if app is using cache so that it can be updated
                if (internetController.showRefresh.value &&
                    watchViewController.isCachedUsed.value) {
                  watchViewController.getUpcomingMovies();
                } else if (!watchViewController.isCachedUsed.value) {
                  Get.snackbar('Up-to-date', 'No need to refresh.');
                } else {
                  Get.snackbar('Network Error',
                      'Please check your internet connection.');
                }
              },
              child: Stack(
                children: [
                  Obx(() => watchViewController.showSearch.value
                      ? SearchView()
                      : Center(
                          child: SizedBox(
                              height: s.height,
                              width: s.width * 0.95,
                              child: watchViewController.isLoading.value &&
                                      watchViewController.upcomingMovies.isEmpty
                                  ? simpleShimmerLoading(s)
                                  : watchListView(
                                      context: context,
                                      movies:
                                          watchViewController.upcomingMovies,
                                      size: s)),
                        )),

                  //pull to refresh widget
                  Obx(() => internetController.showRefresh.value &&
                          watchViewController.isCachedUsed.value
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 700),
                            child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.green.shade200),
                                onPressed: () {
                                  watchViewController.getUpcomingMovies();
                                },
                                icon: const Icon(Icons.refresh),
                                label: CustomText.smallText('Pull to refresh',
                                    color: Colors.white)),
                          ),
                        )
                      : const SizedBox())
                ],
              ))),
    );
  }
}
