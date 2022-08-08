import 'package:flutter/material.dart';
import '../model/post_data.dart';
import '../providers/connectivity_provider.dart';
import '../services/weather.dart';
import '../utilities/config.dart';
import '../utilities/get_category.dart';
import 'package:provider/provider.dart';
import '../utilities/wp_api_data_access.dart';
import 'news_card_skeleton.dart';
import 'package:http/http.dart' as http;
import 'carousel_slider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'shimmer_effect.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int? id;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  WeatherModel weather = WeatherModel();

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  bool isRefresh = true;

  int currentPage = 1;
  List<PostData> sliderPosts = [];
  List<PostData> posts = [];

  Future<bool> getSliderData() async {
    final Uri latestPostUrls =
        Uri.parse("${Config.apiURL}${Config.latestPostsURL}&page=1");
    final response = await http.get(latestPostUrls);
    if (response.statusCode == 200) {
      final result = postDataFromJson(response.body);
      sliderPosts = result;
      return true;
    }

    return false;
  }

  Future<bool> getPostData({bool refresh = false}) async {
    if (refresh) {
      if (mounted) {
        setState(() {});
        currentPage = widget.id == 0 ? 2 : 1;
      }
    }
    final Uri latestPostUrls =
        Uri.parse("${Config.apiURL}${Config.latestPostsURL}&page=$currentPage");
    final Uri categoryWiseUrls = Uri.parse(
        "${Config.apiURL}${Config.categoryPostURL}${widget.id} &page=$currentPage");

    final response =
        await http.get(widget.id == 0 ? latestPostUrls : categoryWiseUrls);

    if (response.statusCode == 200) {
      final result = postDataFromJson(response.body);

      if (refresh) {
        posts = result;
      } else {
        posts.addAll(result);
      }
      if (mounted) {
        setState(() {});
        currentPage++;
      }

      return true;
    } else {
      return false;
    }
  }

  void onRefresh() async {
    getCategory();
    refreshController.refreshCompleted();
    if (Provider.of<ConnectivityProvider>(context, listen: false).isOnline) {
      if (mounted) {
        setState(() {
          isRefresh = true;
        });
      }

      var isFirstPage = true;
      if (widget.id == 0) {
        isFirstPage = await getSliderData();
      }
      final result = await getPostData(refresh: true);
      if (result == true && isFirstPage == true) {
        if (mounted) {
          setState(() {
            isRefresh = false;
          });
        }
      } else {
        refreshController.refreshFailed();
      }
    }
  }

  void onLoading() async {
    final result = await getPostData(refresh: false);
    if (result == true) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: isRefresh
          ? ShimmerEffect(slider: widget.id == 0 ? true : false)
          : ListView.builder(
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final postData = posts[index];
                Map apiData = apiDataAccess(postData);

                return Column(
                  children: [
                    if (index == 0 && widget.id == 0)
                      SliderWidget(sliderPosts: sliderPosts)
                    else
                      const SizedBox.shrink(),
                    NewsCardSkeleton(
                      postId: apiData["id"],
                      link: apiData["link"],
                      title: apiData["title"],
                      imageUrl: apiData["imageUrl"],
                      content: apiData["content"],
                      date: apiData["date"],
                      avatarUrl: apiData["avatarUrl"],
                      authorName: apiData["authorName"],
                      categoryIdNumbers: apiData["categoryIdNumbers"],
                      shortDescription: apiData["shortDesc"],
                    ),
                  ],
                );
              },
            ),
    );
  }
}
