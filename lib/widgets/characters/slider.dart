import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:treflix/models/move.dart';
import 'package:treflix/screens/itemdetails.dart';

// ignore: must_be_immutable
class CharacterSlider extends StatefulWidget {
  CharacterSlider({super.key, required this.details});
  List<Movie> details;

  @override
  State<CharacterSlider> createState() => _CharacterSliderState();
}

class _CharacterSliderState extends State<CharacterSlider> {
  // final PageController _PageController = PageController();

  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double w = size.width * 0.5;
    return Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSmoothIndicator(
              // ignore: prefer_const_constructors
              effect: JumpingDotEffect(
                  jumpScale: 2,
                  activeDotColor: Colors.red,
                  dotWidth: 8,
                  dotHeight: 8,
                  dotColor: Colors.white),
              activeIndex: pageindex,
              count: 3,
            ),
          ],
        ),
        body: SingleChildScrollView(
          // ignore: prefer_const_constructors
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            CarouselSlider.builder(
              itemCount: widget.details.length,
              itemBuilder: (context, index, realIndex) {
                return ItemDetails(details: widget.details[index]);
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    pageindex = index;
                  });
                },

                padEnds: false,
                viewportFraction: 1,
                enlargeFactor: 0.1,
                height: size.height,
                autoPlay: true,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.easeIn,
                autoPlayInterval: Duration(seconds: 3),
                enableInfiniteScroll: false,
                pauseAutoPlayInFiniteScroll: true,
                // pageSnapping: false
              ),
            ),
          ]),
        ));
  }
}
