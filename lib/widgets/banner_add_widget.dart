import 'package:amazoncloneapp/utils/color_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AddBannerWidget extends StatefulWidget {
  const AddBannerWidget({super.key});

  @override
  State<AddBannerWidget> createState() => _AddBannerWidgetState();
}

class _AddBannerWidgetState extends State<AddBannerWidget> {
  int currentAdd = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double smallAdsHeight = screenSize.width / 3;
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAdd == (largeAds.length - 1)) {
          currentAdd = -1;
        }
        setState(() {
          currentAdd++;
        });
      },
      child: Column(children: [
        Stack(
          children: [
            SizedBox(
              child: Image.network(
                largeAds[currentAdd],
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenSize.width,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      backgroundColor,
                      backgroundColor.withOpacity(0),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          color: backgroundColor,
          width: screenSize.width,
          height: smallAdsHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getSmallAdsFromIndex(0, smallAdsHeight),
              getSmallAdsFromIndex(1, smallAdsHeight),
              getSmallAdsFromIndex(2, smallAdsHeight),
              //getSmallAdsFromIndex(3, smallAdsHeight),
            ],
          ),
        )
      ]),
    );
  }

  Widget getSmallAdsFromIndex(int index, height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        height: 92,
        width: 92,
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.network(smallAds[index]),
          const SizedBox(
            height: 5,
          ),
          Text(adItemNames[index])
        ]),
      ),
    );
  }
}
