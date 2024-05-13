import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:treflix/screens/onBoarding/onboarding_items.dart';
import 'package:treflix/screens/registration/login.dart';

class OnboardinView extends StatefulWidget {
  const OnboardinView({super.key});

  @override
  State<OnboardinView> createState() => _OnboardinViewState();
}

class _OnboardinViewState extends State<OnboardinView> {
  final controller = OnboardItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0x080F1A),
      bottomSheet: Container(
        color: const Color(0XFF060E19),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return (LoginScreen());
                      },
                    )),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color.fromARGB(255, 107, 104, 104),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'Inter'
                      ),
                    ),
                  ),
                  //const Spacer(flex: 1,),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 7,
                      dotHeight: 8,
                      activeDotColor: Colors.blueGrey,
                    ),
                  ),
                  // const  Spacer(flex: 1,),
                  InkWell(
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(microseconds: 600),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff060E19),
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: const Text(
                          '>',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    controller.items[index].img,
                    width: double.infinity,
                    height: size.height,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 3,
                    top: size.height * 0.84,
                    child: Column(
                      children: [
                        Text(
                          controller.items[index].text1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 26,
                              fontFamily: 'sad',
                              color: Color(0XFFFCF7F7)),
                        ),
                        Text(
                          controller.items[index].text2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 26,
                              fontFamily: 'sad',
                              color: Color(0XFFFCF7F7)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff030910),
        ),
        width: MediaQuery.of(context).size.width,
        height: 43,
        child: TextButton(
          onPressed: () async {
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);

            if (!mounted) return;

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text(
            'Get Started',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
