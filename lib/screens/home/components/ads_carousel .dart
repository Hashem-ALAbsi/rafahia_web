import 'package:flutter/material.dart';
import 'package:rafahia_web/uitles/colors.dart';

class AdsImages extends StatefulWidget {
  const AdsImages({super.key});

  @override
  State<AdsImages> createState() => _AdsImagesState();
}

class _AdsImagesState extends State<AdsImages> {
  List<String> images = [
    'assets/images/first.jpg',
    'assets/images/second.jpg',
    'assets/images/first.jpg',
    'assets/images/second.jpg',
    'assets/images/first.jpg',
    'assets/images/second.jpg',
  ];
  int current = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _autoplay();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.4, // 40% of the screen height
          width: double.infinity,
          child: PageView.builder(
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  current = index;
                });
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: height * 0.4, // 40% of the screen height
                    width: double.infinity,
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) {
            return buildIndicator(index == current);
          }),
        )
      ],
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Container(
      margin: EdgeInsets.all(2),
      width: isSelected ? 12 : 8,
      height: isSelected ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? LigthColor.maingreencolor : Colors.grey,
      ),
    );
  }

  void _autoplay() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) {
      if (current < images.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 3000),
          curve: Curves.ease,
        );
        _autoplay();
      } else {
        _pageController.jumpToPage(0);
        _autoplay();
      }
    }
  }
}
