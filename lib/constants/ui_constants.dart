import 'package:dsa_proj/constants/asset_constants.dart';
import 'package:dsa_proj/features/tweet/widgets/tweet_list.dart';
import 'package:dsa_proj/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        // color: Pallete.blueColor,
        height: 30,
      ),
      // title: Image.asset("C:/Users/Sahil/dsa_proj/assets/svgs/logo.png"),
      centerTitle: true,
    );
  }

  static const List<Widget> BottomTabBarPages = [
    TweetList(),
    Text("Search Screen"),
    Text("Noti Screen"),
  ];
}
