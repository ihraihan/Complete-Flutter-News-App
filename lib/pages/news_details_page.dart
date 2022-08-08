import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../hiveDB/db_function.dart';
import '../hiveDB/boxes.dart';
import '../providers/theme_provider.dart';
import '../utilities/constants.dart';
import '../utilities/get_category.dart';

class NewsDetailsPage extends StatefulWidget {
  final String? title,
      link,
      imageUrl,
      content,
      date,
      avatarUrl,
      authorName,
      shortDescription;
  final int postId;
  final List<int>? categoryIdNumbers;
  const NewsDetailsPage({
    Key? key,
    required this.postId,
    this.link,
    this.title,
    this.imageUrl,
    this.content,
    this.date,
    this.avatarUrl,
    this.authorName,
    this.categoryIdNumbers,
    this.shortDescription,
  }) : super(key: key);

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 62,
            leading: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: const Color.fromARGB(87, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 56.0,
                    color: const Color.fromARGB(87, 0, 0, 0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await Share.share(widget.link!);
                      },
                    ),
                  ),
                ),
              ),
            ],
            snap: false,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
                background: Hero(
              tag: widget.imageUrl!,
              child: Image.network(
                widget.imageUrl!,
                fit: BoxFit.cover,
              ),
            )),
            expandedHeight: (MediaQuery.of(context).size.height) / 3,
          ),
          SliverToBoxAdapter(
            child: newsDetailSection(),
          ),
        ],
      ),
    );
  }

  Widget newsDetailSection() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(
            style: {
              "body": Style(
                fontSize: FontSize.xLarge,
                margin: const EdgeInsets.symmetric(vertical: 18),
                fontWeight: FontWeight.bold,
              ),
            },
            data: widget.title,
          ),
          row1(),
          const SizedBox(height: 16),
          row2(),
          const SizedBox(height: 14),

          //Content Widget
          Html(
            onLinkTap: ((url, context, attributes, element) async {
              Uri convertedUrl = Uri.parse(url!);
              if (await canLaunchUrl(convertedUrl)) {
                await launchUrl(
                  convertedUrl,
                );
              }
            }),
            style: {
              "body": Style(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  fontFamily: "OpenSans",
                  lineHeight: LineHeight.rem(1.2)),
              "p": Style(
                fontSize: FontSize.larger,
              ),
              "figure":
                  Style(padding: EdgeInsets.zero, margin: EdgeInsets.zero),
              "a": Style(
                color: Colors.blue,
                textDecoration: TextDecoration.none,
              ),
            },
            data: widget.content,
          ),
        ],
      ),
    );
  }

  Widget row1() {
    final isDarkTheme = Provider.of<ThemeProvider>(context).darkTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.access_time_filled_rounded,
              size: 26,
              color: Colors.grey,
            ),
            const SizedBox(width: 5),
            Text(
              widget.date!,
              style: TextStyle(
                  fontSize: 14,
                  color: isDarkTheme
                      ? Colors.white
                      : Colors.black.withOpacity(0.60)),
            ),
          ],
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 12,
              backgroundImage: NetworkImage(widget.avatarUrl!),
            ),
            const SizedBox(width: 5),
            Text(
              widget.authorName!,
              style: TextStyle(
                  color: isDarkTheme
                      ? Colors.white
                      : Colors.black.withOpacity(0.60)),
            ),
          ],
        )
      ],
    );
  }

  Widget row2() {
    final isDarkTheme = Provider.of<ThemeProvider>(context).darkTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: (MediaQuery.of(context).size.width) / 1.5,
            height: 32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categoryIdNumbers!.length,
              itemBuilder: (context, index) {
                final postCategoryName =
                    categoryMap!["${widget.categoryIdNumbers![index]}"];

                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(129, 224, 224, 224),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                        child: Text(
                          postCategoryName!,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )),
                );
              },
            ),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: Boxes.savePosts().listenable(),
            builder: (context, box, _) {
              return Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    if (Boxes.savePosts().containsKey("${widget.postId}")) {
                      deleteSavedArticle(postId: widget.postId);
                    } else {
                      saveArticle(
                        postId: widget.postId,
                        imageUrl: widget.imageUrl,
                        title: widget.title,
                        shortDescription: widget.shortDescription,
                        content: widget.content,
                        date: widget.date,
                        authorName: widget.authorName,
                        avatarUrl: widget.avatarUrl,
                        categoryIdNumbers: widget.categoryIdNumbers,
                      );
                    }
                  },
                  child: Boxes.savePosts().containsKey("${widget.postId}")
                      ? TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween<double>(begin: 28, end: 34),
                          builder:
                              (BuildContext context, dynamic value, child) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDarkTheme
                                    ? kSlideActiveColor
                                    : Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    color: isDarkTheme
                                        ? kContentColorLightTheme
                                        : Colors.grey.withOpacity(0.8),
                                    spreadRadius: 0.3,
                                    blurRadius: 0.4,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: value - 12,
                              ),
                            );
                          })
                      : TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 500),
                          tween: Tween<double>(begin: 34, end: 28),
                          builder:
                              (BuildContext context, dynamic value, child) {
                            return Icon(
                              Icons.favorite_outline,
                              size: value - 2,
                              color: isDarkTheme
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.70),
                            );
                          },
                        ),
                ),
              );
            }),
      ],
    );
  }
}
