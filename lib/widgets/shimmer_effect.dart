import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/theme_provider.dart';
import '../utilities/constants.dart';
import '../utilities/responsive_height.dart';

class ShimmerEffect extends StatefulWidget {
  const ShimmerEffect({
    Key? key,
    required this.slider,
  }) : super(key: key);

  final bool slider;
  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  int currentPos = 0;

  final List<String> imageList = ["ggggg", "nnn", "lll", "yy", "ff", "nnnnn"];

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).darkTheme;

    double screenHeight = MediaQuery.of(context).size.height;

    double sliderHeight = sliderDynamicScreen(screenHeight);
    double cardHeight = newscardDynamicScreen(screenHeight);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: index == 0
                    ? Visibility(
                        visible: widget.slider,
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: 6,
                              itemBuilder: (context, indexOfSlider, realIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Shimmer.fromColors(
                                      baseColor: isDarkTheme
                                          ? const Color.fromARGB(
                                              255, 37, 37, 70)
                                          : Colors.black.withOpacity(0.05),
                                      highlightColor: isDarkTheme
                                          ? const Color.fromARGB(
                                              255, 87, 87, 114)
                                          : kContentColorDarkTheme
                                              .withOpacity(.10),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: const Skeleton(
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                onPageChanged: ((index, reason) {
                                  setState(() {
                                    currentPos = index;
                                  });
                                }),
                                height: sliderHeight - 5,
                                enlargeCenterPage: true,
                                viewportFraction: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imageList.map((url) {
                                int index = imageList.indexOf(url);
                                return Container(
                                  width: currentPos == index ? 24.0 : 12,
                                  height: 6.5,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    shape: BoxShape.rectangle,
                                    color: isDarkTheme
                                        ? currentPos == index
                                            ? kSlideActiveColor
                                            : kPrimaryColor
                                        : currentPos == index
                                            ? Colors.red
                                            : kPrimaryColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      )
                    : Card(
                        color: isDarkTheme ? kSecondaryColor : null,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: isDarkTheme
                              ? const Color.fromARGB(255, 37, 37, 70)
                              : Colors.black.withOpacity(0.05),
                          highlightColor: isDarkTheme
                              ? const Color.fromARGB(255, 87, 87, 114)
                              : kContentColorDarkTheme.withOpacity(0.10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height: cardHeight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Skeleton(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        height: cardHeight,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Skeleton(
                                            width: double.infinity,
                                            height: cardHeight / 5,
                                          ),
                                          const SizedBox(height: 5),
                                          Skeleton(
                                            width: double.infinity,
                                            height: cardHeight / 2.5,
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Row(
                                                  children: [
                                                    Skeleton(
                                                      width: 20,
                                                      height: cardHeight / 7,
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Skeleton(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      height: cardHeight / 7,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    this.width,
    this.height,
    this.radius = 16.0,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(radius)),
    );
  }
}
