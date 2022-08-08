import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './screens/route1.dart';
import './screens/route2.dart';
import './screens/route3.dart';
import './home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // * Slider
          PageView(
            controller: _controller,
            children: [Route1(), Route2(), Route3()],
            onPageChanged: (route) => {
              setState((() => {
                    onLastPage = (route == 2),
                  }))
            },
          ),

          // * Dot Indicator
          Container(
            alignment: Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //* Skip btn
                GestureDetector(
                  onTap: () => {
                    _controller.jumpToPage(2),
                  },
                  child: Text('Skip'),
                ),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),
                //* Next btn
                onLastPage
                    ? GestureDetector(
                        onTap: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }))
                        },
                        child: Text('Done'),
                      )
                    : GestureDetector(
                        onTap: () => {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          )
                        },
                        child: Text('Next'),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
