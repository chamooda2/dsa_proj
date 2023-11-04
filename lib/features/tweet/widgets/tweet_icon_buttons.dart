import 'package:dsa_proj/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TweetIconButton extends StatelessWidget {
  final String path;
  final String text;
  final VoidCallback onTap;
  const TweetIconButton({
    super.key,
    required this.path,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(children: [
        SvgPicture.asset(
          path,
          color: Pallete.greyColor,
        ),
        Container(
          margin: const EdgeInsets.all(6),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        )
      ]),
    );
  }
}
